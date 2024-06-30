import 'package:contractus/screen/client%20screen/client_authentication/client_otp_verification.dart';
import 'package:contractus/screen/seller%20screen/seller%20authentication/seller_forgot_password.dart';
import 'package:contractus/screen/widgets/custom_buttons/social_logins.dart';
import 'package:contractus/screen/widgets/topbars/sellerbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:contractus/controller/authcontroller.dart';
import 'package:contractus/screen/welcome%20screen/welcome_screen.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:get/get.dart';

import '../../widgets/button_global.dart';
import '../../widgets/constant.dart';
import '../../widgets/icons.dart';
import '../seller home/seller_home.dart';

class SellerLogIn extends StatefulWidget {
  const SellerLogIn({Key? key}) : super(key: key);

  @override
  State<SellerLogIn> createState() => _SellerLogInState();
}

class _SellerLogInState extends State<SellerLogIn> {
  final TextEditingController _emailController = TextEditingController();

  String firstname = '';
  String lastname = '';
  String phoneno = '';
  String password = '';
  String email = '';

  final Auth_Controller authcontroller = Get.put(Auth_Controller());
  final _formKey = GlobalKey<FormState>();

  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kWhite,
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50.0),
              bottomRight: Radius.circular(50.0),
            ),
          ),
          toolbarHeight: 180,
          flexibleSpace: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Icon(Icons.arrow_back),
                ),
              ),
              Center(
                child: Container(
                  height: 85,
                  width: MediaQuery.of(context).size.width - 50,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('images/logo2.png'),
                        fit: BoxFit.fitHeight),
                  ),
                ),
              )
            ],
          ),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20.0),
                  Center(
                    child: Text(
                      'Log In Your Account',
                      style: kTextStyle.copyWith(
                          color: kNeutralColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  TextFormField(
                    controller: _emailController,
                    onSaved: (String? value) {
                      String trimmedvalueEmail = _emailController.text.trim();
                      setState(() {
                        email = trimmedvalueEmail;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: kNeutralColor,
                    textInputAction: TextInputAction.next,
                    decoration: kInputDecoration.copyWith(
                      labelText: 'User Name / Email',
                      labelStyle: kTextStyle.copyWith(color: kNeutralColor),
                      hintText: 'Enter your user name / email',
                      hintStyle: kTextStyle.copyWith(color: kLightNeutralColor),
                      focusColor: kNeutralColor,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    onSaved: (value) {
                      setState(() {
                        password = value!;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                    },
                    cursorColor: kNeutralColor,
                    keyboardType: TextInputType.emailAddress,
                    obscureText: hidePassword,
                    textInputAction: TextInputAction.done,
                    decoration: kInputDecoration.copyWith(
                      border: const OutlineInputBorder(),
                      labelText: 'Password*',
                      labelStyle: kTextStyle.copyWith(color: kNeutralColor),
                      hintText: 'Please enter your password',
                      hintStyle: kTextStyle.copyWith(color: kLightNeutralColor),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            hidePassword = !hidePassword;
                          });
                        },
                        icon: Icon(
                          hidePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: kLightNeutralColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () =>
                            const SellerForgotPassword().launch(context),
                        child: Text(
                          'Forgot Password?',
                          style: kTextStyle.copyWith(color: kLightNeutralColor),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  ButtonGlobalWithoutIcon(
                      buttontext: 'Log In',
                      buttonDecoration: kButtonDecoration.copyWith(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            User? user = await authcontroller
                                .signInWithEmailAndPassword(email, password);
                            if (user != null) {
                              // Sign-in successful, navigate to home screen
                              Get.offAll(const SellerHome());
                            }
                          }
                        } else {
                          // Show an error message or highlight invalid fields
                        }
                      },
                      buttonTextColor: kWhite),
                  const SizedBox(height: 20.0),
                  Row(
                    children: [
                      const Expanded(
                        child: Divider(
                          thickness: 1.0,
                          color: kBorderColorTextField,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        child: Text(
                          'Or Sign up with',
                          style: kTextStyle.copyWith(color: kSubTitleColor),
                        ),
                      ),
                      const Expanded(
                        child: Divider(
                          thickness: 1.0,
                          color: kBorderColorTextField,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  const SocialLogins(),
                  const SizedBox(height: 20.0),
                  Center(
                    child: GestureDetector(
                      onTap: () => const WelcomeScreen().launch(context),
                      child: RichText(
                        text: TextSpan(
                          text: 'Don’t have an account? ',
                          style: kTextStyle.copyWith(color: kSubTitleColor),
                          children: [
                            TextSpan(
                              text: 'Create New Account',
                              style: kTextStyle.copyWith(
                                  color: kPrimaryColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}