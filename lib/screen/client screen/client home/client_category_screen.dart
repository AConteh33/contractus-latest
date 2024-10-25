import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:contractus/screen/widgets/cards/jobcard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../controller/datacontroller.dart';
import '../../../models/service.dart';
import '../../widgets/bottomsheetfilter.dart';
import '../../widgets/custom_buttons/button_global.dart';
import '../../widgets/cards/servicecard.dart';
import '../../widgets/constant.dart';
import '../../widgets/searcbox.dart';

class ClientCategoryScreen extends StatefulWidget {
  ClientCategoryScreen({required this.titlecategory});
  String titlecategory;

  @override
  State<ClientCategoryScreen> createState() => _ClientCategoryScreenState();
}

class _ClientCategoryScreenState extends State<ClientCategoryScreen> {

  Widget _buildBottomSheet(
      BuildContext context,
      ScrollController scrollController,
      double bottomSheetOffset,
      ) {
    return Material(
      child: BottomSheetFilter(),
    );
  }

  List<String> serviceList = [
    'All',
    'Logo Design',
    'Brand Style Guide',
    'Fonts & Typography',
  ];

  String selectedServiceList = 'All';



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkWhite,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: kDarkWhite,
        centerTitle: true,
        iconTheme: const IconThemeData(color: kNeutralColor),
        title: Text(
          'Popular Services for ${widget.titlecategory}',
          style: kTextStyle.copyWith(color: kNeutralColor, fontWeight: FontWeight.bold),
        ),
        actions: [

          // GestureDetector(
          //   onTap: (){
          //
          //     showFlexibleBottomSheet(
          //       minHeight: 0,
          //       initHeight: 0.5,
          //       maxHeight: 1,
          //       context: context,
          //       builder: _buildBottomSheet,
          //       anchors: [0, 0.5, 1],
          //       isSafeArea: true,
          //     );
          //
          //
          //   },
          //   child: const Padding(
          //     padding: EdgeInsets.only(right: 15.0),
          //     child: Icon(
          //       FeatherIcons.sliders,
          //       color: kPrimaryColor,
          //     ),
          //   ),
          // )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: GetBuilder<DataController>(
          init: DataController(),
          builder: (data) {
            return Container(
              decoration: const BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: Column(
                children: [
                  Row(
                  children: [
                    Expanded(
                        child: SearchBox(
                      hint: 'Job Search...',
                            istherenext: false,
                            jobsearch: false,
                            controller: null
                        )
                    ),
                    GestureDetector(
                      onTap: (){

                        showFlexibleBottomSheet(
                          minHeight: 0,
                          initHeight: 0.5,
                          maxHeight: 1,
                          context: context,
                          builder: _buildBottomSheet,
                          anchors: [0, 0.5, 1],
                          isSafeArea: true,
                        );


                      },
                      child: const Padding(
                        padding: EdgeInsets.only(right: 15.0),
                        child: Icon(
                          FeatherIcons.sliders,
                          color: kPrimaryColor,
                        ),
                      ),
                    )
                  ],
                ),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [

                          // const SizedBox(height: 5.0),
                          //
                          // ButtonGlobal(buttontext: 'Filter Search', onPressed: (){
                          //   showFlexibleBottomSheet(
                          //     minHeight: 0,
                          //     initHeight: 0.5,
                          //     maxHeight: 1,
                          //     context: context,
                          //     builder: _buildBottomSheet,
                          //     anchors: [0, 0.5, 1],
                          //     isSafeArea: true,
                          //   );
                          // },),
                          // HorizontalList(
                          //   padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                          //   itemCount: serviceList.length,
                          //   itemBuilder: (_, i) {
                          //     return Padding(
                          //       padding: const EdgeInsets.only(bottom: 10.0),
                          //       child: GestureDetector(
                          //         onTap: () {
                          //           setState(() {
                          //             selectedServiceList = serviceList[i];
                          //           });
                          //         },
                          //         child: Container(
                          //           padding: const EdgeInsets.all(10),
                          //           decoration: BoxDecoration(
                          //             color: selectedServiceList == serviceList[i] ? kPrimaryColor : kDarkWhite,
                          //             borderRadius: BorderRadius.circular(40.0),
                          //           ),
                          //           child: Text(
                          //             serviceList[i],
                          //             style: kTextStyle.copyWith(
                          //               color: selectedServiceList == serviceList[i] ? kWhite : kNeutralColor,
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //     );
                          //   },
                          // ),

                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: data.jobModellist.length,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.zero,
                              itemBuilder: (_, i) {

                                return JobCard(
                                  jobmodel: data.jobModellist[i],
                                );

                              },
                            ).visible(selectedServiceList == 'All'),
                          ),



                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}
