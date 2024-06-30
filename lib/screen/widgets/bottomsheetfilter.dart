import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import 'constant.dart';

class BottomSheetFilter extends StatefulWidget {

  BottomSheetFilter();

  // BuildContext context;
  // ScrollController scrollController;
  // double bottomSheetOffset;


  @override
  State<BottomSheetFilter> createState() => _BottomSheetFilterState();
}

class _BottomSheetFilterState extends State<BottomSheetFilter> {

  List<String> serviceList = [
    'All',
    'Logo Design',
    'Brand Style Guide',
    'Fonts & Typography',
  ];

  List<String> distanceList = [
    'All',
    '1 km',
    '5 km',
    '10 km',
    '20 km',
  ];

  List<String> priceList = [
    'All',
    '1,000',
    '10,000',
    '20,000',
    '30,000',
  ];

  String selectedServiceList = 'All';

  Widget listing(category,list){

    String selected = 'All';

    return ListTile(

      title: Text(category),
      subtitle: HorizontalList(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
        itemCount: list.length,
        itemBuilder: (_, i) {

          return Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selected = list[i];
                });
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: selected == list[i] ? kPrimaryColor : kDarkWhite,
                  borderRadius: BorderRadius.circular(40.0),
                ),
                child: Text(
                  list[i],
                  style: kTextStyle.copyWith(
                    color: selected == list[i] ? kWhite : kNeutralColor,
                  ),
                ),
              ),
            ),
          );

        },
      ),
    );

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 5,),
        listing('Category',serviceList),
        listing('Distance',distanceList),
        listing('Price',priceList),
      ],
    );
  }
}
