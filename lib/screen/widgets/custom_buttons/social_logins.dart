import 'package:contractus/controller/authcontroller.dart';
import 'package:contractus/screen/widgets/constant.dart';
import 'package:contractus/screen/widgets/icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SocialLogins extends StatelessWidget {

  Auth_Controller authy = Get.put(Auth_Controller());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed:(){
              authy.signInWithGoogle();
            },
            icon: const SocialIcon(
              bgColor: kWhite,
              iconColor: kNeutralColor,
              icon: FontAwesomeIcons.google,
              borderColor: kBorderColorTextField,
            ),
          ),
        ],
      ),
    );
  }
}
