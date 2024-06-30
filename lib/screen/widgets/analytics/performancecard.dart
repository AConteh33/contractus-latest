import 'package:contractus/models/sellermodels/sellerstats.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import '../constant.dart';
import '../data.dart';

class PerformanceCard extends StatefulWidget {
  PerformanceCard({required this.sellerstatModel});

  SellerstatModel sellerstatModel;

  @override
  State<PerformanceCard> createState() => _PerformanceCardState();
}

class _PerformanceCardState extends State<PerformanceCard> {

  DropdownButton<String> getPerformancePeriod() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String des in period) {
      var item = DropdownMenuItem(
        value: des,
        child: Text(
          des,
          style: kTextStyle.copyWith(color: kSubTitleColor),
        ),
      );
      dropDownItems.add(item);
    }
    return DropdownButton(
      icon: const Icon(FeatherIcons.chevronDown),
      items: dropDownItems,
      value: selectedPeriod,
      style: kTextStyle.copyWith(color: kSubTitleColor),
      onChanged: (value) {
        setState(() {
          selectedPeriod = value!;
        });
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: kBorderColorTextField),
        boxShadow: const [
          BoxShadow(
            color: kDarkWhite,
            blurRadius: 5.0,
            spreadRadius: 2.0,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(
                'Performance',
                style: kTextStyle.copyWith(color: kNeutralColor, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              SizedBox(
                height: 30,
                child: Container(
                  padding: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    border: Border.all(color: kLightNeutralColor),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: getPerformancePeriod(),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15.0),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Summary(
                  title: widget.sellerstatModel.performanceModel.orderscomplete +' Orders',
                  subtitle: 'Order Completions',
                ),
              ),
              SizedBox(width: 10.0),
              Expanded(
                flex: 1,
                child: Summary2(
                  title1: widget.sellerstatModel.performanceModel.positiverating,
                  title2: '5.0',
                  subtitle: 'Positive Ratings',
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Summary(
                  title: widget.sellerstatModel.performanceModel.ontimedelivery +'% On time',
                  subtitle: 'On-Time-Delivery',
                ),
              ),
              SizedBox(width: 10.0),
              Expanded(
                flex: 1,
                child: Summary(
                  title: 'Gigs ${widget.sellerstatModel.performanceModel.totalgig}',
                  subtitle: 'Total Gig',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
