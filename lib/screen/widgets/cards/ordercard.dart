import 'package:contractus/models/sellermodels/ordermodel.dart';
import 'package:contractus/screen/seller%20screen/orders/seller_order_details.dart';
import 'package:contractus/screen/widgets/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:slide_countdown/slide_countdown.dart';


class OrderCard extends StatefulWidget {
  OrderCard({required this.orderModel, required this.status});
  OrderModel orderModel;
  String status;
  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {

  Widget tile({title,detail}){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Text(
            title,
            style: kTextStyle.copyWith(color: kSubTitleColor),
          ),
        ),
        Expanded(
          flex: 3,
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
                  detail,
                  style: kTextStyle.copyWith(color: kSubTitleColor),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
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
    return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                SellerOrderDetails(
                                  orderModel: widget.orderModel,
                                ).launch(context);
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10.0),
                              width: context.width(),
                              decoration: BoxDecoration(
                                  color: kWhite,
                                  borderRadius: BorderRadius.circular(8.0),
                                  border: Border.all(color: kBorderColorTextField),
                                  boxShadow: const [BoxShadow(color: kDarkWhite, spreadRadius: 4.0, blurRadius: 4.0, offset: Offset(0, 2))]),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(right: 3.0),
                                          child: SizedBox(
                                            height: 20,
                                            child: Text(
                                              'Contract Details',
                                              overflow: TextOverflow.ellipsis,
                                              style: kTextStyle.copyWith(
                                                color: kNeutralColor, fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      //Active
                                      widget.status == 'Active' ?
                                      SlideCountdownSeparated(
                                        duration: const Duration(days: 3),
                                        separatorType: SeparatorType.symbol,
                                        separatorStyle: kTextStyle.copyWith(color: Colors.transparent),
                                        decoration: BoxDecoration(
                                          color: kPrimaryColor,
                                          borderRadius: BorderRadius.circular(3.0),
                                        ),
                                      ):
                                      // Pending
                                      widget.status == 'Pending' ?
                                      SlideCountdownSeparated(
                                            showZeroValue: true,
                                            duration: const Duration(days: 0),
                                            separatorType: SeparatorType.symbol,
                                            separatorStyle: kTextStyle.copyWith(color: Colors.transparent),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFBFBFBF),
                                              borderRadius: BorderRadius.circular(3.0),
                                            ),
                                          ):
                                          // Completed
                                          SlideCountdownSeparated(
                                            showZeroValue: true,
                                            duration: Duration(days: widget.orderModel.deadline.toDate().day),
                                            separatorType: SeparatorType.symbol,
                                            separatorStyle: kTextStyle.copyWith(color: Colors.transparent),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFBFBFBF),
                                              borderRadius: BorderRadius.circular(3.0),
                                            ),
                                          )
                                    ],
                                  ),
                                  const SizedBox(height: 10.0),
                                  RichText(
                                    text: TextSpan(
                                      text: 'Seller: ',
                                      style: kTextStyle.copyWith(color: kLightNeutralColor),
                                      children: [
                                        TextSpan(
                                          text: widget.orderModel.seller,
                                          style: kTextStyle.copyWith(color: kNeutralColor),
                                        ),
                                        TextSpan(
                                          text: '  |  ',
                                          style: kTextStyle.copyWith(color: kLightNeutralColor),
                                        ),
                                        TextSpan(
                                          text: widget.orderModel.datestr,
                                          style: kTextStyle.copyWith(color: kLightNeutralColor),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 8.0),
                                  const Divider(
                                    thickness: 1.0,
                                    color: kBorderColorTextField,
                                    height: 1.0,
                                  ),
                                  const SizedBox(height: 8.0),
                                  tile(title: 'Title',detail: widget.orderModel.title,),
                                  const SizedBox(height: 8.0),
                                  tile(title: 'Category',detail: widget.orderModel.category,),
                                  const SizedBox(height: 8.0),
                                  tile(
                                    title: 'Sub-Category',
                                    detail: widget.orderModel.subcategory,
                                  ),
                                  const SizedBox(height: 8.0),
                                  tile(title: 'Duration',detail: widget.orderModel.duration,),
                                  const SizedBox(height: 8.0),
                                  tile(title: 'Amount',detail: '$currencySign ${widget.orderModel.amount}',),
                                  const SizedBox(height: 8.0),
                                  tile(title: 'Status',detail: widget.status,),
                                ],
                              ),
                            ),
                          ),
                        );
  }
  }