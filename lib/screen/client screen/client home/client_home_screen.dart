import 'package:contractus/controller/datacontroller.dart';
import 'package:contractus/models/category.dart';
import 'package:contractus/models/categorymodel.dart';
import 'package:contractus/models/service.dart';
import 'package:contractus/screen/widgets/cards/category.dart';
import 'package:contractus/screen/widgets/titleviewmore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../widgets/cards/sellerscard.dart';
import '../../widgets/cards/servicecard.dart';
import '../../widgets/constant.dart';
import '../../widgets/mapbutton.dart';
import '../../widgets/searcbox.dart';
import '../../widgets/topbars/client_home_bar.dart';

class ClientHomeScreen extends StatefulWidget {
  ClientHomeScreen({this.signedin = false, this.onback = false});
  bool signedin;
  bool onback;

  @override
  State<ClientHomeScreen> createState() => _ClientHomeScreenState();
}

class _ClientHomeScreenState extends State<ClientHomeScreen> {




  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kDarkWhite,
        appBar: AppBar(
          backgroundColor: kDarkWhite,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: ClientHomeBar(
            signedin: widget.signedin,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Container(
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
              child: GetBuilder<DataController>(
                  init: DataController(),
                  builder: (data) {

                    return Column(
                      children: [

                        SearchBox(
                          hint: 'Job Search...',
                          istherenext: true, jobsearch: true,
                        ),

                        const SizedBox(height: 10.0),

                        const MapButton(),

                        // HorizontalList(
                        //   physics: const BouncingScrollPhysics(),
                        //   padding: const EdgeInsets.only(left: 15),
                        //   spacing: 10.0,
                        //   itemCount: 10,
                        //   itemBuilder: (_, i) {
                        //     return Container(
                        //       height: 140,
                        //       width: 304,
                        //       decoration: BoxDecoration(
                        //         borderRadius: BorderRadius.circular(8.0),
                        //         image: const DecorationImage(image: AssetImage('images/mapwrld.jpg'), fit: BoxFit.cover),
                        //       ),
                        //       // child: ,
                        //     );
                        //   },
                        // ),

                        const SizedBox(height: 25.0),

                        TitleViewMore(
                          ontap: () {},
                          title: 'Categories',
                        ),

                        HorizontalList(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.only(
                              top: 20, bottom: 20, left: 15.0, right: 15.0),
                          spacing: 10.0,
                          itemCount: data.categorylist.length,
                          itemBuilder: (_, i) {
                            return CategoryCard(
                              category: data.categorylist[i]
                            );
                          },
                        ),

                        TitleViewMore(
                          ontap: () {},
                          title: 'Local Jobs',
                        ),

                        HorizontalList(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.only(
                              top: 20, bottom: 20, left: 15.0, right: 15.0),
                          spacing: 10.0,
                          itemCount: data.serviceModellist.length,
                          itemBuilder: (_, i) {
                            return ServiceCard(
                              servicedata: data.serviceModellist[i]);
                          },
                        ),

                        TitleViewMore(
                          ontap: () {},
                          title: 'Top Sellers',
                        ),

                        HorizontalList(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.only(
                              top: 20, bottom: 20, left: 15.0, right: 15.0),
                          spacing: 10.0,
                          itemCount: data.sellerlist.length,
                          itemBuilder: (_, i) {
                            return SellersCard(
                              seller: data.sellerlist[i],
                            );
                          },
                        ),

                        TitleViewMore(
                          ontap: () {},
                          title: 'Recent Local jobs',
                        ),

                        HorizontalList(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.only(
                              top: 20, bottom: 10, left: 15.0, right: 15.0),
                          spacing: 10.0,
                          itemCount: data.serviceModellist.length,
                          itemBuilder: (_, i) {
                            return ServiceCard(
                              servicedata: data.serviceModellist[i]
                            );
                          },
                        ),
                      ],
                    );
                  }),
            ),
          ),
        ),
      ),
    );
  }
}
