import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/instance_manager.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../controller/authcontroller.dart';
import '../../widgets/constant.dart';
import '../client dashboard/client_dashboard.dart';
import '../client favourite/client_favourite_list.dart';
import '../client invite/client_invite.dart';
import '../client report/client_report.dart';
import '../client_setting/client_setting.dart';
import '../deposit/add_deposit.dart';
import '../deposit/deposit_history.dart';
import '../transaction/transaction.dart';
import 'client_profile_details.dart';

class ClientProfile extends StatefulWidget {
  const ClientProfile({Key? key}) : super(key: key);

  @override
  State<ClientProfile> createState() => _ClientProfileState();
}



class _ClientProfileState extends State<ClientProfile> {

  final Auth_Controller authController = Get.find<Auth_Controller>();

  Widget listitem({required title,required icon,required VoidCallback ontap}){

    return ListTile(
      onTap: ontap,
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
        // appBar: AppBar(
        //   backgroundColor: kDarkWhite,
        //   elevation: 0,
        //   iconTheme: const IconThemeData(color: kNeutralColor),
        //   titleSpacing: 0,
        //   title: ListTile(
        //     visualDensity: const VisualDensity(vertical: -4),
        //     contentPadding: EdgeInsets.zero,
        //     leading: Container(
        //       height: 45,
        //       width: 45,
        //       padding: const EdgeInsets.all(10.0),
        //       decoration: const BoxDecoration(
        //         shape: BoxShape.circle,
        //         color: kDarkWhite,
        //         image: DecorationImage(image: AssetImage('images/profile1.png'), fit: BoxFit.cover),
        //       ),
        //     ),
        //     title: Text(
        //       'Shahidul Islam',
        //       overflow: TextOverflow.ellipsis,
        //       maxLines: 1,
        //       style: kTextStyle.copyWith(color: kNeutralColor),
        //     ),
        //     subtitle: RichText(
        //       text: TextSpan(
        //         text: 'Deposit Balance: ',
        //         style: kTextStyle.copyWith(color: kLightNeutralColor),
        //         children: [
        //           TextSpan(
        //             text: '$currencySign 500.00',
        //             style: kTextStyle.copyWith(color: kNeutralColor),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ),
        //   centerTitle: true,
        // ),
        body: GetBuilder<Auth_Controller>(
          init: Auth_Controller(),
          builder: (data) {
            return Column(
              children: [
                const SizedBox(height: 10,),
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
                            image: AssetImage('images/profile3.png'),
                            fit: BoxFit.cover
                        ),
                      ),
                    ),
                    title: Text(
                      data.authData.value!.name,
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
                            text: data.authData.value!.role,
                            style: kTextStyle.copyWith(color: kNeutralColor),
                          ),
                        ],
                      ),
                    ),
                  )
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Container(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      width: context.width(),
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

                            listitem(
                                title: 'My Profile',
                                icon: IconlyBold.profile,
                                ontap: () => const ClientProfileDetails().launch(context)
                            ),

                            // listitem(
                            //     title: 'Dashboard',
                            //     icon: IconlyBold.chart,
                            //     ontap: () => const const ClientDashBoard().launch(context)
                            // ),

                            // listitem(
                            //     title: 'Transaction',
                            //     icon: IconlyBold.ticketStar,
                            //     ontap: () => const ClientTransaction().launch(context)
                            // ),

                            // listitem(
                            //     title: 'Favorite',
                            //     icon: IconlyBold.heart,
                            //     ontap: () => const ClientFavList().launch(context)
                            // ),

                            // listitem(
                            //     title: 'Seller Report',
                            //     icon: IconlyBold.document,
                            //     ontap: () => const ClientReport().launch(context)
                            // ),

                            listitem(
                                title: 'Setting',
                                icon: IconlyBold.setting,
                                ontap: () => const ClientSetting().launch(context)
                            ),

                            listitem(
                                title: 'Invite Friends',
                                icon: IconlyBold.addUser,
                                ontap: () => const ClientInvite().launch(context)
                            ),

                            listitem(
                                title: 'Help & Support',
                                icon: IconlyBold.danger,
                                ontap: () => const ClientSetting().launch(context)
                            ),

                            listitem(
                                title: 'Log Out',
                                icon: IconlyBold.logout,
                                ontap: () => data.signOut(context)
                            ),

                            // Theme(
                            //   data: ThemeData(dividerColor: Colors.transparent),
                            //   child: ExpansionTile(
                            //     childrenPadding: EdgeInsets.zero,
                            //     tilePadding: const EdgeInsets.only(bottom: 10),
                            //     collapsedIconColor: kLightNeutralColor,
                            //     iconColor: kLightNeutralColor,
                            //     title: Text(
                            //       'Deposit',
                            //       style: kTextStyle.copyWith(color: kNeutralColor),
                            //     ),
                            //     leading: Container(
                            //       padding: const EdgeInsets.all(10.0),
                            //       decoration: const BoxDecoration(
                            //         shape: BoxShape.circle,
                            //         color: Color(0xFFFFEFE0),
                            //       ),
                            //       child: const Icon(
                            //         IconlyBold.wallet,
                            //         color: Color(0xFFFF7A00),
                            //       ),
                            //     ),
                            //     trailing: const Icon(
                            //       FeatherIcons.chevronDown,
                            //       color: kLightNeutralColor,
                            //     ),
                            //     children: [
                            //       ListTile(
                            //         visualDensity: const VisualDensity(vertical: -3),
                            //         horizontalTitleGap: 10,
                            //         contentPadding: const EdgeInsets.only(left: 60),
                            //         title: Text(
                            //           'Add Deposit',
                            //           overflow: TextOverflow.ellipsis,
                            //           maxLines: 1,
                            //           style: kTextStyle.copyWith(color: kNeutralColor),
                            //         ),
                            //         trailing: const Icon(
                            //           FeatherIcons.chevronRight,
                            //           color: kLightNeutralColor,
                            //         ),
                            //         onTap: () => const AddDeposit().launch(context),
                            //       ),
                            //       ListTile(
                            //         onTap: () => const DepositHistory().launch(context),
                            //         visualDensity: const VisualDensity(vertical: -3),
                            //         horizontalTitleGap: 10,
                            //         contentPadding: const EdgeInsets.only(left: 60),
                            //         title: Text(
                            //           'Deposit History',
                            //           overflow: TextOverflow.ellipsis,
                            //           maxLines: 1,
                            //           style: kTextStyle.copyWith(color: kNeutralColor),
                            //         ),
                            //         trailing: const Icon(
                            //           FeatherIcons.chevronRight,
                            //           color: kLightNeutralColor,
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),

                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        ),
      ),
    );
  }
}
