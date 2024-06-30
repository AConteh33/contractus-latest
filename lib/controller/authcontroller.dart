import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contractus/controller/datacontroller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../models/auth_data.dart';
import '../screen/welcome screen/welcome_screen.dart';


class Auth_Controller extends GetxController{
  Rxn<AuthData> authData = Rxn<AuthData>();

  FirebaseAuth fireauth = FirebaseAuth.instance;
  FirebaseFirestore firedata = FirebaseFirestore.instance;
  RxBool signedin = false.obs;
  RxString role = ''.obs;
  DataController datactrl = DataController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Isignedin();
    datactrl.getSellerListData();
    datactrl.getCategoryListData();
    datactrl.getServiceListData();
  }

  Isignedin(){

    String uid;

    if(fireauth.currentUser != null){
      uid = fireauth.currentUser!.uid;
      signedin.value = true;
      getuserdata(uid: uid);
    }else{
      signedin.value = false;
    }

    update();

    // return fireauth.currentUser!.uid;

  }

  getuserdata({uid}) async {

    // It's not working Right now.
    String usrid = fireauth.currentUser!.uid;

    final usrdata = await firedata
        .collection('users')
        .doc(usrid)
        .get();

    authData.value = AuthData(
        email: usrdata['email'],
        id: usrdata['id'],
        name: usrdata['name'],
        role: usrdata['role'],
        firstname: usrdata['firstname'],
        lastname: usrdata['lastname'],

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
        MaterialPageRoute(builder: (context) =>  const WelcomeScreen()),
      );
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.message ?? 'Unknown error');
      return;
    }
  }

  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await fireauth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.message ?? 'Unknown error');
      return null;
    }
  }


  createAccount({
    firstname,
    lastname,
    phone,
    email,
    password,
    role,
  }) async {

    print(' Auth : 1 ' + email + ' ' + password);

    UserCredential credential =
    await fireauth.createUserWithEmailAndPassword(
        email: email,
        password: password
      );

      print('Auth : 2');

    if(credential.user == null){

      print('Auth : 3');

      return false;

    }else{

      print('Auth : 4');

      firedata.collection('users')
          .doc(credential.user!.uid)
          .set({
        'email': email,
        'id': credential.user!.uid,
        'name': firstname + ' ' + lastname,
        'firstname': firstname,
        'lastname': lastname,
        'role': role,
      });

      firedata.collection('users')
          .doc(credential.user!.uid)
          .collection('performance')
          .doc('10/5/2020').set({
        'ontimedelivery':'0',
        'orderscomplete':'0',
        'positiverating':'0.0',
        'totalgig':'0 of 0',
      });

      firedata.collection('users')
          .doc(credential.user!.uid)
          .collection('earning')
          .doc('10/5/2020').set({
        'activeorders':0.0,
        'currentbalance':0.0,
        'totalearning':0.0,
        'withdrawearning':0.0,
      });

      firedata.collection('users')
          .doc(credential.user!.uid)
          .collection('statistics')
          .doc('10/5/2020').set({
        'impressions':0.0,
        'interaction':0.0,
        'reachedout':0.0,
      });

      authData.value = AuthData(
        email: email,
        id: credential.user!.uid,
        name: firstname + ' ' + lastname,
        role: role,
        firstname: firstname,
        lastname: lastname,
    );
    
    update();
    Isignedin();
    
    return true;
      
      }
  
    }


}