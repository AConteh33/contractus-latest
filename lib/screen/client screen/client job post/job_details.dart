import 'package:contractus/models/job_model.dart';
import 'package:contractus/screen/seller%20screen/seller%20messgae/chat_inbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:contractus/screen/widgets/custom_buttons/button_global.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../controller/authcontroller.dart';
import '../../../models/auth_data.dart';
import '../../widgets/constant.dart';
import '../client popup/client_popup.dart';

class JobDetails extends StatefulWidget {
  JobDetails({required this.jobmodel});
  JobModel jobmodel;

  @override
  State<JobDetails> createState() => _JobDetailsState();
}

class _JobDetailsState extends State<JobDetails> {
  //__________cancel_order_reason_popup________________________________________________
  void cancelOrderPopUp() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder:
              (BuildContext context, void Function(void Function()) setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: const CancelJobPopUp(),
            );
          },
        );
      },
    );
  }

  Widget listitemdetail({title,description}){
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
                style:
                kTextStyle.copyWith(color: kSubTitleColor),
              ),
              const SizedBox(width: 10.0),
              Flexible(
                child: Text(
                  description,
                  style: kTextStyle.copyWith(
                      color: kSubTitleColor),
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

  Auth_Controller authy = Get.put(Auth_Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkWhite,
      appBar: AppBar(
        backgroundColor: kDarkWhite,
        elevation: 0,
        iconTheme: const IconThemeData(color: kNeutralColor),
        title: Text(
          'Job Details',
          style: kTextStyle.copyWith(
              color: kNeutralColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          authy.authData.value!.id == widget.jobmodel.postby ?
          PopupMenuButton(
            padding: EdgeInsets.zero,
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                // onTap: (){
                //   cancelOrderPopUp();
                // },
                child: Text(
                  'Cancel',
                  style: kTextStyle.copyWith(color: kNeutralColor),
                ).onTap(
                  () => cancelOrderPopUp(),
                ),
              )
            ],
            onSelected: (value) {},
            child: const Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Icon(
                Icons.more_vert_rounded,
                color: kNeutralColor,
              ),
            ),
          ): const SizedBox(),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
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
                  boxShadow: const [
                    BoxShadow(
                      color: kDarkWhite,
                      spreadRadius: 4.0,
                      blurRadius: 4.0,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.jobmodel.title,
                      style: kTextStyle.copyWith(
                          color: kNeutralColor, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10.0),
                    ReadMoreText(
                      widget.jobmodel.desc,
                      style: kTextStyle.copyWith(color: kSubTitleColor),
                      trimLines: 2,
                      colorClickableText: kPrimaryColor,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: '..Read more',
                      trimExpandedText: '..Read less',
                    ),
                    const SizedBox(height: 15.0),
                    listitemdetail(title: 'Category',description: widget.jobmodel.category),
                    const SizedBox(height: 8.0),
                    listitemdetail(title: 'Subcategory',description: widget.jobmodel.subcategory),
                    const SizedBox(height: 8.0),
                    listitemdetail(title: 'Delivery Time',description: widget.jobmodel.estduration),
                    const SizedBox(height: 8.0),
                    listitemdetail(title: 'Service Price',description: widget.jobmodel.paymentrate),
                    const SizedBox(height: 8.0),
                    // listitemdetail(title: 'Status',description: widget.jobmodel.status),
                    // const SizedBox(height: 8.0),
                    listitemdetail(title: 'Date',description: widget.jobmodel.datestr),
                    const SizedBox(height: 8.0),
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
