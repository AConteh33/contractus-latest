import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contractus/const/textformat.dart';
import 'package:contractus/models/sellermodels/ordermodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../controller/datasettercontroller.dart';
import '../../seller screen/orders/seller_order_details.dart';

class SendOfferCard extends StatefulWidget {
  SendOfferCard(
      {required this.message, required this.iseller, required this.name});

  String message;
  bool iseller;
  String name;

  @override
  State<SendOfferCard> createState() => _SendOfferCardState();
}

class _SendOfferCardState extends State<SendOfferCard> {

  Widget custombutton({text, colour, onTap}) {
    return SizedBox(
      height: 50,
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          color: colour,
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }

  Widget customExpandedButton({text, colour, onTap}) {
    return Expanded(
      flex: 1,
      child: SizedBox(
        height: 50,
        child: GestureDetector(
          onTap: onTap,
          child: Card(
            color: colour,
            child: Center(
              child: Text(
                text,
                style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
      ),
    );
  }

  DataSetterController datasetter = Get.put(DataSetterController());

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.all(widget.message.contains('%%') ? 10 : 16),
      margin: const EdgeInsets.symmetric(vertical: 2.5, horizontal: 2.5),
      child: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('contracts')
              .doc(widget.message.replaceAll('%%', ''))
              .snapshots(),
          builder: (context, snapshot) {
            //Create a datamodel here

            OrderModel contract = OrderModel.fromMap(
                snapshot.data!.data() as Map<String, dynamic>);

            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 7,
                      ),
                      Text(
                        'Sent an offer',
                        style: TextStyle(
                            fontSize: 10,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                      Spacer(),
                      Text(
                        snapshot.data?['status'],
                        style: TextStyle(
                            fontSize: 10,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        width: 7,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 180,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Card(
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(
                                snapshot.data?['title'],
                                style: const TextStyle(
                                    fontSize: 13,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                              ),
                              const Spacer(),
                              Text(
                                snapshot.data?['datestr'],
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Card(
                          elevation: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              // height: 220,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Description',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    limitText(
                                        snapshot.data?['description'],
                                        snapshot.data?['status'] == 'Pending'
                                            ? 50
                                            : 50),
                                    style: const TextStyle(
                                        fontSize: 13, color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      widget.iseller
                          ? Column(
                              children: [
                                snapshot.data?['status'] == 'Pending'
                                    ? Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            customExpandedButton(
                                                text: 'Accept',
                                                colour: Colors.green,
                                                onTap: () {
                                                  datasetter
                                                      .changestatusContract(
                                                          contractId: widget
                                                              .message
                                                              .replaceAll(
                                                                  '%%', ''),
                                                          status: 'Active',
                                                          name: widget.name);
                                                  setState(() {});
                                                }),
                                            customExpandedButton(
                                                text: 'View Details',
                                                colour: Colors.grey,
                                                onTap: () {
                                                  SellerOrderDetails(
                                                    orderModel: contract,
                                                  ).launch(context);
                                                }),
                                            customExpandedButton(
                                                text: 'Reject',
                                                colour: Colors.red,
                                                onTap: () {
                                                  datasetter
                                                      .changestatusContract(
                                                          contractId: widget
                                                              .message
                                                              .replaceAll(
                                                                  '%%', ''),
                                                          status: 'Reject',
                                                          name: widget.name);
                                                  setState(() {});
                                                }),
                                          ],
                                        ),
                                      )
                                    : snapshot.data?['status'] == 'Active'
                                        ? custombutton(
                                            text: 'View Details',
                                            colour: Colors.grey,
                                            onTap: () {
                                              SellerOrderDetails(
                                                orderModel: contract,
                                              ).launch(context);
                                              setState(() {});
                                            })
                                        : snapshot.data?['status'] ==
                                                'Completed'
                                            ? custombutton(
                                                text: 'Completed',
                                                colour: Colors.green,
                                                onTap: () {
                                                  SellerOrderDetails(
                                                    orderModel: contract,
                                                  ).launch(context);
                                                  setState(() {});
                                                })
                                            : snapshot.data?['status'] ==
                                                    'Cancelled'
                                                ? custombutton(
                                                    text: 'Cancelled',
                                                    colour: Colors.green,
                                                    onTap: () {
                                                      SellerOrderDetails(
                                                        orderModel: contract,
                                                      ).launch(context);
                                                      setState(() {});
                                                    })
                                                : custombutton(
                                                    text: 'View Details',
                                                    colour: Colors.grey,
                                                    onTap: () {
                                                      SellerOrderDetails(
                                                        orderModel: contract,
                                                      ).launch(context);
                                                      setState(() {});
                                                    }),
                              ],
                            )
                          : custombutton(
                              text: 'View Details',
                              colour: Colors.grey,
                              onTap: () {
                                SellerOrderDetails(
                                  orderModel: contract,
                                ).launch(context);
                                setState(() {});
                              }),
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }
}
