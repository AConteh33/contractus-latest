import 'package:contractus/controller/authcontroller.dart';
import 'package:contractus/controller/datacontroller.dart';
import 'package:contractus/screen/widgets/cards/ordercard.dart';
import 'package:contractus/screen/widgets/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:contractus/screen/seller%20screen/orders/seller_order_details.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:slide_countdown/slide_countdown.dart';

import '../../widgets/constant.dart';

class SellerOrderList extends StatefulWidget {
  const SellerOrderList({Key? key}) : super(key: key);

  @override
  State<SellerOrderList> createState() => _SellerOrderListState();
}

class _SellerOrderListState extends State<SellerOrderList> {

  DataController datactrlr = DataController();
  Auth_Controller authy = Auth_Controller();
  FirebaseAuth fireauth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(authy.signedin.value){
      print('Running function ${authy.authData.value!.role}');
      datactrlr.getmyOrderListData(
          id: fireauth.currentUser!.uid,
          iseller: authy.authData.value!.role == 'seller'
      );
    }

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
        //   title: Text(
        //     'Orders',
        //     style: kTextStyle.copyWith(color: kNeutralColor, fontWeight: FontWeight.bold),
        //   ),
        //   centerTitle: true,
        // ),
        body: GetBuilder<DataController>(
          // init: DataController(),
          builder: (data) {
            return Column(
              children: [
                SizedBox(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Text(
                      'Contracts',
                      style: kTextStyle.copyWith(
                          color: kNeutralColor,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 0.0),
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            HorizontalList(
                              padding: const EdgeInsets.only(left: 15.0, top: 15.0),
                              itemCount: titleList.length,
                              itemBuilder: (_, i) {

                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isSelected = titleList[i];
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30.0),
                                      color: isSelected == titleList[i] ? kPrimaryColor : kDarkWhite,
                                    ),
                                    child: Text(
                                      titleList[i],
                                      style: kTextStyle.copyWith(color: isSelected == titleList[i] ? kWhite : kNeutralColor),
                                    ),
                                  ),
                                );

                              },
                            ),

                            const SizedBox(height: 15.0),

                            // data.loading.value ?
                            // LoadingWidget(isloading: true, child: Container()) :
                            ListView.builder(
                              padding: EdgeInsets.zero,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: data.ordermodel.value.length,
                              itemBuilder: (_, i) {

                                if(data.ordermodel.value[i].status == isSelected){
                                  return OrderCard(
                                    orderModel: data.ordermodel.value[i],
                                    status: isSelected,
                                  );
                                }else{}

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
          }
        ),
      ),
    );
  }
}
