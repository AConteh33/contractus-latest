import 'package:contractus/controller/authcontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../client screen/client notification/client_notification.dart';
import '../../welcome screen/welcome_screen.dart';
import '../constant.dart';


class HomeBar extends StatelessWidget {
  HomeBar({this.signedin = false});
  bool signedin;

  // Auth_Controller authy = Get.put(Auth_Controller());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Auth_Controller>(
      init: Auth_Controller(),
      builder: (auth) {

        return ListTile(
          contentPadding: const EdgeInsets.only(top: 10),
          leading: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: GestureDetector(
              // onTap: ()=>const SellerProfile().launch(context),
              child: signedin ? Container(
                height: 44,
                width: 44,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(image: AssetImage('images/profile3.png'), fit: BoxFit.cover),
                ),
              ): Container(
                height: 44,
                width: 90,
                decoration: const BoxDecoration(
                  // shape: BoxShape.circle,
                  image: DecorationImage(image: AssetImage('images/logo2.png'), fit: BoxFit.fitWidth),
                ),
              ),
            ),
          ),
          title: signedin ? Text(
            auth.authData.value!.name,
            style: kTextStyle.copyWith(
                color: kNeutralColor,
                fontWeight: FontWeight.bold
            ),
          ) : const SizedBox(),
          subtitle: signedin ? Text(
            'I’m a ${auth.authData.value!.role}',
            style: kTextStyle.copyWith(
                color: kLightNeutralColor
            ),
          ) : const SizedBox(),
          trailing: GestureDetector(
            onTap: () => const WelcomeScreen().launch(context),
            child: signedin ? GestureDetector(
              onTap: () => const ClientNotification().launch(context),
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: kPrimaryColor.withOpacity(0.2),
                  ),
                ),
                child: const Icon(
                  IconlyLight.notification,
                  color: kNeutralColor,
                ),
              ),
            ): Container(
              width: 80,
              height: 40,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.all(
                  color: kPrimaryColor.withOpacity(0.2),
                ),
              ),
              child: Center(
                child: Text(
                  'Sign in',
                  style: kTextStyle.copyWith(color: Colors.green),
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}
