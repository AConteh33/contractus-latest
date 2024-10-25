import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:contractus/screen/widgets/custom_buttons/button_global.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../controller/authcontroller.dart';
import '../../widgets/constant.dart';
import 'client_edit_profile_details.dart';

class ClientProfileDetails extends StatefulWidget {
  const ClientProfileDetails({Key? key}) : super(key: key);

  @override
  State<ClientProfileDetails> createState() => _ClientProfileDetailsState();
}

class _ClientProfileDetailsState extends State<ClientProfileDetails> {

  Widget detailitem({required title,required answer}){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            title,
            style: kTextStyle.copyWith(color: kSubTitleColor),
          ),
        ),
        Expanded(
          flex: 4,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ':',
                style: kTextStyle.copyWith(color: kSubTitleColor),
              ),
              const SizedBox(width: 10.0),
              Flexible(
                child: Text(
                  answer,
                  style: kTextStyle.copyWith(color: kSubTitleColor),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkWhite,
      appBar: AppBar(
        backgroundColor: kDarkWhite,
        elevation: 0,
        iconTheme: const IconThemeData(color: kNeutralColor),
        title: Text(
          'My Profile',
          style: kTextStyle.copyWith(
              color: kNeutralColor,
              fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: ButtonGlobalWithIcon(
        buttontext: 'Edit Profile',
        buttonDecoration: kButtonDecoration.copyWith(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(30.0),
        ),
        onPressed: () {
          setState(() {
            const ClientEditProfile().launch(context);
          });
        },
        buttonTextColor: kWhite,
        buttonIcon: IconlyBold.edit,
      ),
      body: GetBuilder<Auth_Controller>(
          init: Auth_Controller(),
          builder: (data) {
          return Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Container(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15.0),
                    Row(
                      children: [
                        Container(
                          height: 80,
                          width: 80,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage('images/profile3.png'),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data.authData.value!.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: kTextStyle.copyWith(color: kNeutralColor, fontWeight: FontWeight.bold, fontSize: 18.0),
                            ),
                            Text(
                              data.authData.value!.email,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: kTextStyle.copyWith(color: kLightNeutralColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    Text(
                      'Client Information',
                      style: kTextStyle.copyWith(color: kNeutralColor, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 15.0),
                    detailitem(title: 'First Name', answer: data.authData.value!.firstname),
                    const SizedBox(height: 10.0),
                    detailitem(title: 'Last Name', answer: data.authData.value!.lastname),
                    const SizedBox(height: 10.0),
                    detailitem(title: 'Email', answer: data.authData.value!.email),
                    const SizedBox(height: 10.0),
                    detailitem(title: 'Phone Number', answer: data.authData.value!.phone),
                    const SizedBox(height: 10.0),
                    detailitem(title: 'Country', answer: data.authData.value!.country),
                    const SizedBox(height: 10.0),
                    detailitem(title: 'Address', answer: data.authData.value!.address),
                    const SizedBox(height: 10.0),
                    detailitem(title: 'City', answer: data.authData.value!.city),
                    const SizedBox(height: 10.0),
                    // detailitem(title: 'ZIP/Post Code', answer: data.authData.value!.),
                    // const SizedBox(height: 10.0),
                    // detailitem(title: 'First Name', answer: data.authData.value!.firstname),
                    // Row(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     Expanded(
                    //       flex: 2,
                    //       child: Text(
                    //         'Language',
                    //         style: kTextStyle.copyWith(color: kSubTitleColor),
                    //       ),
                    //     ),
                    //     Expanded(
                    //       flex: 4,
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.start,
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           Text(
                    //             ':',
                    //             style: kTextStyle.copyWith(color: kSubTitleColor),
                    //           ),
                    //           const SizedBox(width: 10.0),
                    //           Flexible(
                    //             child: Text(
                    //               'English',
                    //               style: kTextStyle.copyWith(color: kSubTitleColor),
                    //               overflow: TextOverflow.ellipsis,
                    //               maxLines: 2,
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // const SizedBox(height: 10.0),
                    // detailitem(title: 'First Name', answer: data.authData.value!.firstname),
                    // Row(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     Expanded(
                    //       flex: 2,
                    //       child: Text(
                    //         'Gender',
                    //         style: kTextStyle.copyWith(color: kSubTitleColor),
                    //       ),
                    //     ),
                    //     Expanded(
                    //       flex: 4,
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.start,
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           Text(
                    //             ':',
                    //             style: kTextStyle.copyWith(color: kSubTitleColor),
                    //           ),
                    //           const SizedBox(width: 10.0),
                    //           Flexible(
                    //             child: Text(
                    //               'Male',
                    //               style: kTextStyle.copyWith(color: kSubTitleColor),
                    //               overflow: TextOverflow.ellipsis,
                    //               maxLines: 2,
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
