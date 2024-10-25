import 'package:contractus/screen/seller%20screen/profile/seller_profile_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../controller/authcontroller.dart';
import '../../widgets/constant.dart';

class SellerProfile extends StatefulWidget {
  @override
  State<SellerProfile> createState() => _SellerProfileState();
}

class _SellerProfileState extends State<SellerProfile> {
  final Auth_Controller authController = Get.put(Auth_Controller());

  Widget listItem({required String title, required IconData icon, required Function() onTap}) {
    return ListTile(
      onTap: onTap,
      visualDensity: const VisualDensity(vertical: -3),
      horizontalTitleGap: 10,
      contentPadding: const EdgeInsets.only(bottom: 20),
      leading: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFFE2EED8),
        ),
        child: Icon(
          icon,
          color: kPrimaryColor,
        ),
      ),
      title: Text(
        title,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: kTextStyle.copyWith(color: kNeutralColor),
      ),
      trailing: const Icon(
        FeatherIcons.chevronRight,
        color: kLightNeutralColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kDarkWhite,
        body: GetBuilder<Auth_Controller>(
          builder: (controller) {
            return Column(
              children: [
                const SizedBox(height: 10.0),
                SizedBox(
                  height: 40,
                  width: MediaQuery.of(context).size.width - 50,
                  child: ListTile(
                    visualDensity: const VisualDensity(vertical: -4),
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                      height: 45,
                      width: 45,
                      padding: const EdgeInsets.all(10.0),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: kDarkWhite,
                        image: DecorationImage(
                            image: AssetImage('images/profile1.png'),
                            fit: BoxFit.cover),
                      ),
                    ),
                    title: Text(
                      controller.authData.value?.name ?? 'Guest',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: kTextStyle.copyWith(color: kNeutralColor),
                    ),
                    subtitle: RichText(
                      text: TextSpan(
                        text: 'Account type: ',
                        style: kTextStyle.copyWith(color: kLightNeutralColor),
                        children: [
                          TextSpan(
                            text: controller.authData.value?.role ?? 'N/A',
                            style: kTextStyle.copyWith(color: kNeutralColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: kWhite,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                        ),
                      ),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            const SizedBox(height: 20.0),
                            listItem(
                              title: 'My Profile',
                              icon: IconlyBold.profile,
                              onTap: () => const SellerProfileDetails().launch(context),
                            ),
                            listItem(
                              title: 'Invite Friends',
                              icon: IconlyBold.addUser,
                              onTap: () {},
                            ),
                            listItem(
                              title: 'Setting',
                              icon: IconlyBold.setting,
                              onTap: () {},
                            ),
                            listItem(
                              title: 'Help & Support',
                              icon: IconlyBold.danger,
                              onTap: () {},
                            ),
                            listItem(
                              title: 'Log Out',
                              icon: IconlyBold.logout,
                              onTap: () {
                                authController.signOut(context);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
