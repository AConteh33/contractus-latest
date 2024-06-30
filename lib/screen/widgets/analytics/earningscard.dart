import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import '../../../models/sellermodels/sellerstats.dart';
import '../constant.dart';
import '../data.dart';

class EarningsCard extends StatefulWidget {
  EarningsCard({required this.sellerstatModel});

  SellerstatModel sellerstatModel;

  @override
  State<EarningsCard> createState() => _EarningsCardState();
}

class _EarningsCardState extends State<EarningsCard> {

  //__________earning_time_period_____________________________________________________
  DropdownButton<String> getEarningPeriod() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String des in earningPeriod) {
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
      value: selectedEarningPeriod,
      style: kTextStyle.copyWith(color: kSubTitleColor),
      onChanged: (value) {
        setState(() {
          selectedEarningPeriod = value!;
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
                'Earnings',
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
                    child: getEarningPeriod(),
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
                  title: '$currencySign${widget.sellerstatModel.earningModel.totalearning}',
                  subtitle: 'Total Earnings',
                ),
              ),
              SizedBox(width: 10.0),
              Expanded(
                flex: 1,
                child: Summary(
                  title: '$currencySign${widget.sellerstatModel.earningModel.withdrawearning}',
                  subtitle: 'Withdraw Earnings',
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
                  title: '$currencySign${widget.sellerstatModel.earningModel.currentbalance}',
                  subtitle: 'Current Balance',
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                flex: 1,
                child: Summary(
                  title: '$currencySign${widget.sellerstatModel.earningModel.activeorders}',
                  subtitle: 'Active Orders',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
