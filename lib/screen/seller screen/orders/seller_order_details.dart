import 'package:contractus/controller/authcontroller.dart';
import 'package:contractus/controller/datasettercontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:contractus/screen/seller%20screen/orders/seller_deliver_order.dart';
import 'package:contractus/screen/widgets/custom_buttons/button_global.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:slide_countdown/slide_countdown.dart';

import '../../../const/convertto12hourformat.dart';
import '../../../models/sellermodels/ordermodel.dart';
import '../../payment/invoice.dart';
import '../../widgets/constant.dart';
import '../seller popUp/seller_popup.dart';

class SellerOrderDetails extends StatefulWidget {
  SellerOrderDetails({required this.orderModel,});
  OrderModel orderModel;

  @override
  State<SellerOrderDetails> createState() => _SellerOrderDetailsState();
}

class _SellerOrderDetailsState extends State<SellerOrderDetails> {

  Auth_Controller auth = Get.put(Auth_Controller());
  DataSetterController datasetter = Get.put(DataSetterController());

  Widget titledetail({title, desc}){
    return Column(
      children: [
        const SizedBox(height: 8.0),
        Row(
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
                      '$desc',
                      style: kTextStyle.copyWith(color: kSubTitleColor),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
      ],
    );
  }

  //__________cancel_order_reason_popup________________________________________________
  void cancelOrderPopUp() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, void Function(void Function()) setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: const CancelReasonPopUp(),
            );
          },
        );
      },
    );
  }

  //__________order_complete_popup________________________________________________
  void orderCompletePopUp() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, void Function(void Function()) setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: OrderCompletePopUp(ordermodel: widget.orderModel,),
            );
          },
        );
      },
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
          'Contract Details',
          style: kTextStyle.copyWith(color: kNeutralColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: Icon(
                IconlyBold.chat,
                color: kPrimaryColor
            ),
          ),
        ],
      ),
      bottomNavigationBar: widget.orderModel.status == 'Completed'
          ? ButtonGlobalWithoutIcon(
              buttontext: 'Create new contract',
              buttonDecoration: kButtonDecoration.copyWith(
                  color: kPrimaryColor
              ),
              onPressed: () {
                setState(() {
                  // const SellerDeliverOrder().launch(context);
                });
              },
              buttonTextColor: kWhite,
            )
          : auth.authData.value?.role == 'seller' ?
      const SizedBox() :
      Container(
              decoration: const BoxDecoration(
                color: kWhite,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: ButtonGlobalWithoutIcon(
                      buttontext: 'Cancel Contract',
                      buttonDecoration: kButtonDecoration.copyWith(color: kWhite, border: Border.all(color: Colors.red)),
                      onPressed: () {
                        setState(() {
                          datasetter.changestatusContract(
                            contractId: widget.orderModel.contractid,
                            status: 'Cancelled',
                            name: '',
                            iseller: auth.authData.value!.role == 'seller',
                          );
                            isSelected = 'Cancelled';
                          cancelOrderPopUp();
                        });
                      },
                      buttonTextColor: Colors.red,
                    ),
                  ),
                  Expanded(
                    child: ButtonGlobalWithoutIcon(
                      buttontext: 'Completed',
                      buttonDecoration: kButtonDecoration.copyWith(
                        color: kPrimaryColor,
                      ),
                      onPressed: () {
                        setState(() {
                          // const SellerDeliverOrder().launch(context);

                          datasetter.changestatusContract(
                            contractId: widget.orderModel.contractid,
                            status: 'Completed',
                            name: '',
                            iseller: auth.authData.value!.role == 'seller',
                          );
                          orderCompletePopUp();
                            isSelected = 'Completed';
                        });
                      },
                      buttonTextColor: kWhite,
                    ),
                  ),
                ],
              ),
            ),
      body: Container(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
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
              const SizedBox(height: 15.0),
              Container(
                padding: const EdgeInsets.all(10.0),
                width: MediaQuery.of(context).size.width,
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
                        Text(
                          'Contract ID ${widget.orderModel.contractid}',
                          overflow: TextOverflow.ellipsis,
                          style: kTextStyle.copyWith(color: kNeutralColor, fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),

                        widget.orderModel.status == 'Active' ?
                        SlideCountdownSeparated(
                          duration: Duration(days: widget.orderModel.deadline.toDate().day),
                          separatorType: SeparatorType.symbol,

                          separatorStyle: kTextStyle.copyWith(color: Colors.transparent),
                          decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(3.0),
                          ),
                        ): widget.orderModel.status == 'Pending' ?
                        // Pending
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
                        // SlideCountdownSeparated(
                        //   duration: const Duration(days: 3),
                        //   separatorType: SeparatorType.symbol,
                        //   separatorStyle: kTextStyle.copyWith(color: Colors.transparent),
                        //   decoration: BoxDecoration(
                        //     color: kPrimaryColor,
                        //     borderRadius: BorderRadius.circular(3.0),
                        //   ),
                        // )
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
                            text: formatDate(widget.orderModel.createdAt.toDate()),
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
                    titledetail(title: 'Title',desc: widget.orderModel.title),
                    titledetail(title: 'Service Info',desc: widget.orderModel.description),
                    const SizedBox(height: 8.0),
                    Text(
                      'Important details',
                      style: kTextStyle.copyWith(color: kNeutralColor, fontWeight: FontWeight.bold),
                    ),
                    titledetail(title: 'Category',desc: widget.orderModel.category),
                    titledetail(title: 'Sub-Category',desc: widget.orderModel.subcategory),
                    titledetail(title: 'Duration',desc: widget.orderModel.duration),
                    titledetail(title: 'Status',desc: widget.orderModel.status),
                    const SizedBox(height: 8.0),
                    Text(
                      'Order Summary',
                      style: kTextStyle.copyWith(color: kNeutralColor, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    titledetail(title: 'Subtotal',desc: '$currencySign ${int.parse(widget.orderModel.amount) * 0.9}'),
                    titledetail(title: 'Service',desc: '$currencySign ${int.parse(widget.orderModel.amount) * 0.1}'),
                    titledetail(title: 'Total',desc: '$currencySign ${widget.orderModel.amount}'),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 15.0),
                        Text(
                          'Completed by ${widget.orderModel.seller}',
                          style: kTextStyle.copyWith(color: kNeutralColor, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 15.0),
                        GestureDetector(
                          onTap: (){
                            InvoiceScreen(
                              contract: widget.orderModel,
                            ).launch(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0), border: Border.all(color: kBorderColorTextField)),
                            child: ListTile(
                              visualDensity: const VisualDensity(vertical: -3),
                              contentPadding: EdgeInsets.zero,
                              leading: Container(
                                padding: const EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: kPrimaryColor.withOpacity(0.1),
                                ),
                                child: const Icon(
                                  Icons.check_circle,
                                  color: kPrimaryColor,
                                ),
                              ),
                              title: Text(
                                widget.orderModel.title,
                                style: kTextStyle.copyWith(color: kNeutralColor),
                                maxLines: 1,
                              ),
                              subtitle: Text(
                                'You can download the receipt here',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: kTextStyle.copyWith(color: kSubTitleColor),
                              ),
                              trailing: Container(
                                padding: const EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: kLightNeutralColor.withOpacity(0.1),
                                ),
                                child: const Icon(
                                  FeatherIcons.download,
                                  color: kLightNeutralColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10.0),

                      ],
                    ).visible(isSelected == 'Completed'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
