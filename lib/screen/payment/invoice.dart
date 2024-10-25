import 'package:contractus/controller/pdfcontroller.dart';
import 'package:contractus/screen/widgets/analytics/roundedtop.dart';
import 'package:contractus/screen/widgets/custom_buttons/simplebutton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../const/convertto12hourformat.dart';
import '../../models/sellermodels/ordermodel.dart';
import '../widgets/constant.dart';
import '../widgets/custom_buttons/button_global.dart';

class InvoiceScreen extends StatefulWidget {
  InvoiceScreen({required this.contract});
  OrderModel contract;

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {

  PDFController pdfController = Get.put(PDFController());

  Widget bigtile({title,desc}){
    return SizedBox(
      height: 30,width: MediaQuery.of(context).size.width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            title,
            maxLines: 1,
            style: kTextStyle.copyWith(
                color: kNeutralColor,
                fontWeight: FontWeight.w400,
                fontSize: 25),
          ),
          const SizedBox(width: 5.0),
          Text(
            desc,
            style:
            kTextStyle.copyWith(fontSize: 15),
          ),
        ],
      ),
    );
  }

  Widget bullettile({title}){
    return SizedBox(
      height: 30,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title ,
            maxLines: 1,
            style: kTextStyle.copyWith(
                color: kNeutralColor,
                fontWeight: FontWeight.w800,
                fontSize: 15),
          ),
          const SizedBox(height: 1,),
          Container(
            height: 1,
            width: MediaQuery.of(context).size.width,
            color: kPrimaryColor,
          )
        ],
      ),
    );
  }

  Widget detailtile({title,desc}){
    return SizedBox(
      height: 20,width: MediaQuery.of(context).size.width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Text(
            title + ' :',
            maxLines: 1,
            style: kTextStyle.copyWith(
                color: kNeutralColor,
                fontWeight: FontWeight.w400,
                fontSize: 12),
          ),
          const SizedBox(width: 10.0),
          Text(
            desc,
            style:
            kTextStyle.copyWith(fontSize: 12),
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: const Center(
              child: Text('Invoice'),
            ),
          ),
          Expanded(
            child: RoundedTopBackgorund(
                child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10,),
                    SizedBox(
                        height: 50,width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('images/logo2.png',scale: 0.5,),
                          ],
                        )
                    ),
                    const SizedBox(height: 50,),
                    // bigtile(title: 'Invoice from',desc: widget.contract.client),
                    // const SizedBox(height: 30,),
                    bullettile(title: 'Basic information',),
                    detailtile(title: 'Contract ID',desc: widget.contract.contractid),
                    detailtile(title: 'Creator',desc: widget.contract.client),
                    const SizedBox(height: 15,),
                    bullettile(title: 'Timeline',),
                    detailtile(title: 'Created date',desc: formatDate(widget.contract.createdAt.toDate())),
                    detailtile(title: 'Start',desc: widget.contract.datestr),
                    detailtile(title: 'Due Date',desc: formatDate(widget.contract.deadline.toDate())),
                    const SizedBox(height: 15,),
                    bullettile(title: 'Payment',),
                    detailtile(title: 'Subtotal',desc: '$currencySign ${int.parse(widget.contract.amount) * 0.9}'),
                    detailtile(title: 'Contract Us fee',desc: '$currencySign ${int.parse(widget.contract.amount) * 0.1}'),
                    detailtile(title: 'Total',desc: '$currencySign ${widget.contract.amount}'),
                    bullettile(title: '',),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        'Thank you for using Contract Us. If you have any questions or concerns regarding this invoice,'
                            ' please don\'t hesitate to contact us. We appreciate your business and look forward to working with you again.',
                        // maxLines: 2,
                        style: kTextStyle.copyWith(
                            color: kNeutralColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 12),
                      ),
                    ),
                    // SizedBox(
                    //   height: 50,
                    //   child: Row(
                    //     children: [
                    //
                    //       ButtonGlobalWithoutIcon(
                    //         buttontext: 'Cancel',
                    //         buttonDecoration: kButtonDecoration.copyWith(
                    //           color: kPrimaryColor,
                    //         ),
                    //         onPressed: () {
                    //           Get.back();
                    //         },
                    //         buttonTextColor: kWhite,
                    //       ),
                    //       ButtonGlobalWithoutIcon(
                    //         buttontext: 'Print',
                    //         buttonDecoration: kButtonDecoration.copyWith(
                    //           color: kPrimaryColor,
                    //         ),
                    //         onPressed: () {
                    //
                    //         },
                    //         buttonTextColor: kWhite,
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

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SimpleButton(title: 'Print', ontap: (){pdfController.createPDFinvoice(contract: widget.contract);}),
          ),
        ],
      ),
    );
  }
}
