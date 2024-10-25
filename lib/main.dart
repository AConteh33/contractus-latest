import 'package:contractus/controller/authcontroller.dart';
import 'package:contractus/controller/datacontroller.dart';
import 'package:contractus/screen/client%20screen/client%20home/client_home.dart';
import 'package:contractus/screen/seller%20screen/seller%20home/seller_home.dart';
import 'package:contractus/screen/splash%20screen/mt_splash_screen.dart';
import 'package:contractus/screen/welcome%20screen/tos.dart';
import 'package:contractus/screen/welcome%20screen/welcome_screen.dart';
import 'package:contractus/screen/widgets/loading.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool readtos = true;

  void readData() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      readtos = prefs.getBool('tos') ?? false;
    });

  }

  // DataController datactrl = DataController();
  Auth_Controller authy = Auth_Controller();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readData();
    authy.isignedin();
    // datactrl.getServiceListData();
    // datactrl.loadalldata();
  }


  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      title: 'Contract Us',
      theme: ThemeData(fontFamily: 'Display'),
      home: readtos ?
      GetBuilder<Auth_Controller>(
        init: Auth_Controller(),
        builder: (data) {

          // Perform some action that might cause the state to update
          WidgetsBinding.instance.addPostFrameCallback((_) {
            // Ensure the update is called after the current build frame
            data.isignedin();
          });

          data.isignedin();

          if (data.signedin.value) {

            if (data.authData.value != null) {

              if (data.authData.value!.role == 'client') {

                return ClientHome(
                    signedin: data.signedin.value,
                );

              } else {

                return const SellerHome();

              }

            } else {

              // Handle case where authData.value is null
              return LoadingWidget(
                  isloading: true,
                  child: Container(color: Colors.white,),
              );

            }

          } else {

            return ClientHome(
                signedin: data.signedin.value,
            );

          }

        },

      ) : const TOS_Screen(),
      // const SplashScreen(),
    );
  }

}
