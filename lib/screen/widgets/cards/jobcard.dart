import 'package:contractus/controller/authcontroller.dart';
import 'package:contractus/models/job_model.dart';
import 'package:contractus/screen/client%20screen/client%20job%20post/job_details.dart';
import 'package:contractus/screen/widgets/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as ab;
import 'package:get/get_core/src/get_main.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:nb_utils/nb_utils.dart' as nb;

class JobCard extends StatefulWidget {
  JobCard({required this.jobmodel});

  JobModel jobmodel;

  @override
  State<JobCard> createState() => _JobCardState();
}

class _JobCardState extends State<JobCard> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: GestureDetector(
        onTap: () => JobDetails(
          jobmodel: widget.jobmodel,
        ).launch(context),
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: kWhite,
            border: Border.all(color: kBorderColorTextField),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    widget.jobmodel.title,
                    style: kTextStyle.copyWith(
                        color: kNeutralColor, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  Text(
                    'Budget: ${widget.jobmodel.paymentrate}',
                    style: kTextStyle.copyWith(color: kLightNeutralColor),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              Text(
                widget.jobmodel.desc,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: kTextStyle.copyWith(color: kSubTitleColor),
              ),
              const SizedBox(height: 10.0),
              RichText(
                text: TextSpan(
                  text: 'Category: ',
                  style: kTextStyle.copyWith(color: kNeutralColor),
                  children: [
                    TextSpan(
                      text: widget.jobmodel.category,
                      style: kTextStyle.copyWith(color: kSubTitleColor),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10.0),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                        top: 5.0, bottom: 5.0, left: 10, right: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: kDarkWhite),
                    child: Text(
                      'Date: ${widget.jobmodel.datestr}',
                      style: kTextStyle.copyWith(color: kNeutralColor),
                    ),
                  ),
                  const Spacer(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
