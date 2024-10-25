// import 'package:country_code_picker/country_code_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contractus/controller/authcontroller.dart';
import 'package:contractus/controller/imagecontroller.dart';
import 'package:contractus/models/imageModel.dart';
import 'package:contractus/screen/client%20screen/client_authentication/client_otp_verification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:contractus/controller/authcontroller.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:contractus/screen/seller%20screen/seller%20authentication/verification.dart';
import 'package:contractus/screen/widgets/custom_buttons/button_global.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../widgets/constant.dart';
import '../../widgets/icons.dart';
import '../seller home/seller_home_screen.dart';

class SellerSignUp extends StatefulWidget {
  const SellerSignUp({super.key});

  @override
  State<SellerSignUp> createState() => _SellerSignUpState();
}

class _SellerSignUpState extends State<SellerSignUp> {
  final Auth_Controller authcontroller = Get.put(Auth_Controller());
  MediaController imagectrl = Get.put(MediaController());
  bool hidePassword = true;
  bool isCheck = true;
  String firstname = '';
  String lastname = '';
  String phoneNo = '';
  String password = '';
  String email = '';
  String businessName = '';
  String businessImage = '';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kWhite,
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: kDarkWhite,
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
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Create a New Account',
                      style: kTextStyle.copyWith(
                          color: kNeutralColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    onSaved: (String? value) {
                      setState(() {
                        firstname = value!;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter your first name';
                      }
                    },
                    keyboardType: TextInputType.name,
                    cursorColor: kNeutralColor,
                    textInputAction: TextInputAction.next,
                    decoration: kInputDecoration.copyWith(
                      labelText: 'First Name',
                      labelStyle: kTextStyle.copyWith(color: kNeutralColor),
                      hintText: 'Enter your first name',
                      hintStyle: kTextStyle.copyWith(color: kLightNeutralColor),
                      focusColor: kNeutralColor,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    onSaved: (String? value) {
                      setState(() {
                        lastname = value!;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter your last name';
                      }
                    },
                    keyboardType: TextInputType.name,
                    cursorColor: kNeutralColor,
                    textInputAction: TextInputAction.next,
                    decoration: kInputDecoration.copyWith(
                      labelText: 'Last Name',
                      labelStyle: kTextStyle.copyWith(color: kNeutralColor),
                      hintText: 'Enter your last name',
                      hintStyle: kTextStyle.copyWith(color: kLightNeutralColor),
                      focusColor: kNeutralColor,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    onSaved: (String? value) {
                      setState(() {
                        email = value!;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter your email address';
                      }
                    },
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: kNeutralColor,
                    textInputAction: TextInputAction.next,
                    decoration: kInputDecoration.copyWith(
                      labelText: 'Email',
                      labelStyle: kTextStyle.copyWith(color: kNeutralColor),
                      hintText: 'Enter your email',
                      hintStyle: kTextStyle.copyWith(color: kSubTitleColor),
                      focusColor: kNeutralColor,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    onSaved: (String? value) {
                      setState(() {
                        businessName = value!;
                      });
                    },
                    keyboardType: TextInputType.name,
                    cursorColor: kNeutralColor,
                    textInputAction: TextInputAction.next,
                    decoration: kInputDecoration.copyWith(
                      labelText: 'Business Name',
                      labelStyle: kTextStyle.copyWith(color: kNeutralColor),
                      hintText: 'Enter your Business Name',
                      hintStyle: kTextStyle.copyWith(color: kSubTitleColor),
                      focusColor: kNeutralColor,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    onTap: () async {
                      ImageModel imagedata = await imagectrl.getImageGallery();
                      setState(() {
                        businessImage = imagedata.file!.path;
                      });
                    },
                    showCursor: false,
                    readOnly: true,
                    keyboardType: TextInputType.url,
                    cursorColor: kNeutralColor,
                    textInputAction: TextInputAction.next,
                    decoration: kInputDecoration.copyWith(
                      labelText: businessImage == ''
                          ? 'Upload file and image'
                          : 'Image Uploaded',
                      labelStyle: kTextStyle.copyWith(color: kNeutralColor),
                      hintText: businessImage == ''
                          ? 'Upload file and image'
                          : 'Image Uploaded',
                      hintStyle: kTextStyle.copyWith(color: kSubTitleColor),
                      focusColor: kNeutralColor,
                      border: const OutlineInputBorder(),
                      suffixIcon: const Icon(FeatherIcons.upload,
                          color: kLightNeutralColor),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    onSaved: (String? value) {
                      setState(() {
                        phoneNo = value!;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter your phone number';
                      }
                    },
                    keyboardType: TextInputType.number,
                    cursorColor: kNeutralColor,
                    textInputAction: TextInputAction.next,
                    decoration: kInputDecoration.copyWith(
                        labelText: 'Phone',
                        labelStyle: kTextStyle.copyWith(color: kNeutralColor),
                        hintText: 'Please enter your phone number',
                        hintStyle:
                            kTextStyle.copyWith(color: kLightNeutralColor),
                        focusColor: kNeutralColor,
                        border: const OutlineInputBorder(),
                        // prefixIcon: Container(
                        //   padding: const EdgeInsets.all(5),
                        //   width: context.width(),
                        //   decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), border: Border.all(color: kBorderColorTextField, width: 2.0)),
                        //   child: CountryCodePicker(
                        //     showOnlyCountryWhenClosed: true,
                        //     showCountryOnly: true,
                        //     padding: EdgeInsets.zero,
                        //     onChanged: print,
                        //     initialSelection: 'BD',
                        //     showFlag: true,
                        //     showDropDownButton: false,
                        //     alignLeft: true,
                        //   ),
                        // ),
                        // suffixIcon: const Icon(FeatherIcons.chevronDown),
                        floatingLabelBehavior: FloatingLabelBehavior.always),
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
                      labelText: 'Password',
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Checkbox(
                          activeColor: kPrimaryColor,
                          visualDensity: const VisualDensity(horizontal: -4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2.0),
                          ),
                          value: isCheck,
                          onChanged: (value) {
                            setState(() {
                              isCheck = !isCheck;
                            });
                          }),
                      Flexible(
                        child: RichText(
                          text: TextSpan(
                            text: 'Yes, I understand and agree to the ',
                            style: kTextStyle.copyWith(color: kSubTitleColor),
                            children: [
                              TextSpan(
                                text: 'Terms of Service.',
                                style: kTextStyle.copyWith(
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  ButtonGlobalWithoutIcon(
                      buttontext: 'Sign Up',
                      buttonDecoration: kButtonDecoration.copyWith(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      onPressed: () async {

                        if (_formKey.currentState!.validate()) {

                          _formKey.currentState!.save();

                          try {
                            bool results = await authcontroller.createAccount(
                              firstname: firstname,
                              lastname: lastname,
                              password: password,
                              email: email,
                              businessName: businessName,
                              businessImage: businessImage,
                              phone: phoneNo,
                              role: 'seller',
                            );


                            // UserCredential userCredential = await FirebaseAuth
                            //     .instance
                            //     .createUserWithEmailAndPassword(
                            //   email: email,
                            //   password: password,
                            // );
                            //
                            // // Save additional user to firestore
                            // await FirebaseFirestore.instance
                            //     .collection('users')
                            //     .doc(userCredential.user!.uid)
                            //     .set({
                            //   'name': '$firstname $lastname',
                            //   'id': userCredential.user!.uid,
                            //   'firstname': firstname,
                            //   'lastname': lastname,
                            //   'phoneno': phoneNo,
                            //   'role': 'seller',
                            //   'email': email
                            // });

                            if (results == true) {
                              print('this is what happens');
                              Get.off(() => const SellerHomeScreen());
                            }
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'weak-password') {
                              print('The password provided is too weak.');
                            } else if (e.code == 'email-already-in-use') {
                              print('The account already exists for that email.');
                            }
                          } catch (e) {
                            print(e);
                          }
                        } else {}
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
                  const Padding(
                    padding: EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SocialIcon(
                          bgColor: kWhite,
                          iconColor: kNeutralColor,
                          icon: FontAwesomeIcons.google,
                          borderColor: kBorderColorTextField,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: 'Already have an account? ',
                        style: kTextStyle.copyWith(color: kSubTitleColor),
                        children: [
                          TextSpan(
                            text: 'Log In',
                            style: kTextStyle.copyWith(
                                color: kPrimaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
