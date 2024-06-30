import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import '../../../models/sellermodels/sellerstats.dart';
import '../../seller screen/seller home/seller_home_screen.dart';
import '../chart.dart';
import '../constant.dart';

class StatiscticsCard extends StatefulWidget {
  StatiscticsCard({required this.sellerstatModel});

  SellerstatModel sellerstatModel;

  @override
  State<StatiscticsCard> createState() => _StatiscticsCardState();
}

class _StatiscticsCardState extends State<StatiscticsCard> {

  //__________statistics_time_period_____________________________________________________
  DropdownButton<String> getStatisticsPeriod() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String des in staticsPeriod) {
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
      value: selectedStaticsPeriod,
      style: kTextStyle.copyWith(color: kSubTitleColor),
      onChanged: (value) {
        setState(() {
          selectedStaticsPeriod = value!;
        });
      },
    );
  }

  Map<String, double> dataMap = {
    "Impressions": 5,
    "Interaction": 3,
    "Reached-Out": 2,
  };


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
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Statistics',
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
                    child: getStatisticsPeriod(),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: RecordStatistics(
                  dataMap: {
                    "Impressions": widget.sellerstatModel.statisticModel.impressions,
                    "Interaction": widget.sellerstatModel.statisticModel.interaction,
                    "Reached-Out": widget.sellerstatModel.statisticModel.reachedout,
                  },
                  colorList: colorList,
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    ChartLegend(
                      iconColor: Color(0xFF69B22A),
                      title: 'Impressions',
                      value: widget.sellerstatModel.statisticModel.impressions.toString(),
                    ),
                    ChartLegend(
                      iconColor: Color(0xFF144BD6),
                      title: 'Interaction',
                      value: widget.sellerstatModel.statisticModel.interaction.toString(),
                    ),
                    ChartLegend(
                      iconColor: Color(0xFFFF3B30),
                      title: 'Reached-Out',
                      value: widget.sellerstatModel.statisticModel.reachedout.toString(),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
