import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contractus/controller/datacontroller.dart';
import 'package:contractus/models/sellermodels/sellerstats.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../models/auth_data.dart';
import '../models/sellermodels/earnings.dart';
import '../models/sellermodels/performance.dart';
import '../models/sellermodels/statistics.dart';
import '../screen/welcome screen/welcome_screen.dart';

class Auth_Controller extends GetxController {

  Rxn<AuthData> authData = Rxn<AuthData>();

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: '225967324567-getv3s1rj209la6rb0d8na0kh5541cg4.apps.googleusercontent.com',
  );

  FirebaseAuth fireauth = FirebaseAuth.instance;
  FirebaseFirestore firedata = FirebaseFirestore.instance;
  RxBool signedin = false.obs;
  RxString role = ''.obs;
  SellerstatModel sellerstats = SellerstatModel(
      statisticModel: StatisticModel(impressions: 0, interaction: 0, reachedout: 0),
      earningModel: EarningModel(
          activeorders: 0.0,
          currentbalance: 0.0,
          totalearning: 0.0,
          withdrawearning: 0.0),
      performanceModel: PerformanceModel(
          ontimedelivery: '', orderscomplete: '', positiverating: '', totalgig: '')
  );
  PerformanceModel performanceModel = PerformanceModel(
      ontimedelivery: '', orderscomplete: '', positiverating: '', totalgig: '');
  EarningModel earningModel = EarningModel(
      activeorders: 0.0,
      currentbalance: 0.0,
      totalearning: 0.0,
      withdrawearning: 0.0);

  StatisticModel statisticModel =
  StatisticModel(impressions: 0, interaction: 0, reachedout: 0);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // isignedin();
  }

  isignedin() {

    String uid;

    if (fireauth.currentUser != null) {
      uid = fireauth.currentUser!.uid;
      signedin.value = true;
      getuserdata(uid: fireauth.currentUser!.uid);
    } else {
      signedin.value = false;
    }

    update();

    // return fireauth.currentUser!.uid;
  }

  getotheruser({userid}) async {

    AuthData userdata;

    final usrdata = await firedata.collection('users').doc(userid).get();

    userdata = AuthData(
      email: usrdata['email'],
      id: usrdata['id'],
      name: usrdata['name'],
      role: usrdata['role'],
      firstname: usrdata['firstname'],
      lastname: usrdata['lastname'],
      businessname: "usrdata['Business Name']", aboutme: '',
      // address: usrdata['Business Name'],
    );

    return userdata;

  }

  getuserdata({uid}) async {

    // It's not working Right now.
    String usrid = fireauth.currentUser!.uid;

    final usrdata = await firedata.collection('users').doc(usrid).get();

    authData.value = AuthData(
      email: usrdata['email'],
      id: usrdata['id'],
      name: usrdata['name'],
      role: usrdata['role'],
      firstname: usrdata['firstname'],
      lastname: usrdata['lastname'],
      businessname: "usrdata['Business Name']",
      aboutme: '',
      // address: usrdata['Business Name'],
    );

    update();

    // return authData;
  }

  //updated on 5/26/2024
  Future<void> signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      // Navigate back to the registration screen after logging out
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const WelcomeScreen()),
      );
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.message ?? 'Unknown error');
      return;
    }
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {

    try {

      UserCredential userCredential =
      await fireauth.signInWithEmailAndPassword(
          email: email, password: password
      );

      getuserdata(uid: userCredential.user!.uid);

      return userCredential.user;

    } on FirebaseAuthException catch (e) {

      Get.snackbar('Error', e.message ?? 'Unknown error');

      return null;

    }
  }

  Future<bool> signInWithGoogle() async {

    print('Button pressed');

    try {
      // Check if already signed in and sign out if so
      if (await _googleSignIn.isSignedIn()) {
        await _googleSignIn.signOut();
      }

      // Trigger the Google sign-in flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

        final OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        UserCredential newCredential = await FirebaseAuth.instance.signInWithCredential(credential);

        if (newCredential.user != null) {
          // Check if the user exists in Firestore
          DocumentSnapshot userSnapshot = await firedata
              .collection('users')
              .doc(newCredential.user!.uid)
              .get();

          if (!userSnapshot.exists) {
            User? newUser = newCredential.user;

            // Create a new user in Firestore
            await firedata.collection('users').doc(newUser!.uid).set({
              'email': newUser.email,
              'id': newUser.uid,
              'name': newUser.displayName,
              'firstname': newUser.displayName!.split(" ").first,
              'lastname': newUser.displayName!.split(" ").last,
              "Business Name": '',
              "Business Image": '',
              'role': role.value,
            });

            // Update local user data
            authData.value = AuthData(
              email: newUser.email!,
              id: newUser.uid,
              name: newUser.displayName!,
              role: role.value,
              firstname: newUser.displayName!.split(" ").first,
              lastname: newUser.displayName!.split(" ").last ?? '',
              businessname: '', aboutme: '',
            );
          }

          // Update signed-in status
          signedin.value = true;

          await getuserdata(uid: fireauth.currentUser!.uid);

          update();
          isignedin();

          return true;
        } else {
          print('Error: Firebase sign-in failed.');
          return false;
        }
      } else {
        print('Error: Google sign-in failed.');
        return false;
      }
    } catch (error) {
      print('Error during Google sign-in process: $error');
      return false;
    }
  }

  Future<void> sendVerificationMail() async {
    try {
      await fireauth.currentUser?.sendEmailVerification();
    } catch (e) {
      print(e.toString());
    }
  }

  createAccount({
    firstname,
    lastname,
    phone,
    email,
    businessName,
    password,
    businessImage,
    role,
  }) async {

    // print(' Auth : 1 ' + email + ' ' + password);

    UserCredential credential = await fireauth.createUserWithEmailAndPassword(
        email: email, password: password);

    if (credential.user == null) {

      return false;

    } else {

      firedata.collection('users').doc(credential.user!.uid).set({
        'email': email,
        'id': credential.user!.uid,
        'name': firstname + ' ' + lastname,
        'firstname': firstname,
        'lastname': lastname,
        "Business Name": businessName,
        "Business Image": businessImage,
        'role': role,
      });

      firedata
          .collection('users')
          .doc(credential.user!.uid)
          .collection('performance')
          .doc('10/5/2020')
          .set({
        'ontimedelivery': '0',
        'orderscomplete': '0',
        'positiverating': '0.0',
        'totalgig': '0 of 0',
      });

      firedata
          .collection('users')
          .doc(credential.user!.uid)
          .collection('earning')
          .doc('10/5/2020')
          .set({
        'activeorders': 0.0,
        'currentbalance': 0.0,
        'totalearning': 0.0,
        'withdrawearning': 0.0,
      });

      firedata
          .collection('users')
          .doc(credential.user!.uid)
          .collection('statistics')
          .doc('10/5/2020')
          .set({
        'impressions': 0.0,
        'interaction': 0.0,
        'reachedout': 0.0,
      });

      authData.value = AuthData(
        email: email,
        id: credential.user!.uid,
        name: firstname + ' ' + lastname,
        role: role,
        firstname: firstname,
        lastname: lastname,
        businessname: businessName, aboutme: '',
      );

      update();
      isignedin();

      return true;
    }
  }

  getSellerStats() async {

    String uid = fireauth.currentUser!.uid;

    getuserdata(uid: uid);

    final userperformance = await firedata
        .collection('users')
        .doc(uid)
        .collection('performance')
        .doc('10/5/2020')
        .get();

    final userearning = await firedata
        .collection('users')
        .doc(uid)
        .collection('earning')
        .doc('10/5/2020')
        .get();

    final userstats = await firedata
        .collection('users')
        .doc(uid)
        .collection('statistics')
        .doc('10/5/2020')
        .get();

    // print('Adding data services : '+ element['id']);

    print('Now collection performance data');

    if (userperformance.exists) {
      print('Performance exists');

      performanceModel = PerformanceModel(
        ontimedelivery: userperformance['ontimedelivery'],
        orderscomplete: userperformance['orderscomplete'],
        positiverating: userperformance['positiverating'],
        totalgig: userperformance['totalgig'],
      );
    } else {
      print('Performance doesn\'t exists');

      performanceModel = PerformanceModel(
          ontimedelivery: '0',
          orderscomplete: '0',
          positiverating: '0.0',
          totalgig: '0 of 0');
    }

    if (userearning.exists) {
      print('Performance Exists');

      earningModel = EarningModel(
          activeorders: userearning['activeorders'],
          currentbalance: userearning['currentbalance'],
          totalearning: userearning['totalearning'],
          withdrawearning: userearning['withdrawearning']);
    } else {
      print('Performance doesn\'t exists');

      earningModel = EarningModel(
          activeorders: 0.0,
          currentbalance: 0.0,
          totalearning: 0.0,
          withdrawearning: 0.0);
    }

    if (userstats.exists) {
      print('Performance Exists');

      statisticModel = StatisticModel(
          impressions: userstats['impressions'],
          interaction: userstats['interaction'],
          reachedout: userstats['reachedout']
      );
    } else {
      print('Performance doesn\'t exists');

      statisticModel = StatisticModel(
          impressions: 0.0,
          interaction: 0.0,
          reachedout: 0.0
      );
    }

    sellerstats = SellerstatModel(
        statisticModel: statisticModel,
        earningModel: earningModel,
        performanceModel: performanceModel
    );

    update();
  }

}
