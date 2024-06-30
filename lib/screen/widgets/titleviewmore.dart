
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../client screen/client home/client_all_categories.dart';
import 'constant.dart';


class TitleViewMore extends StatelessWidget {
  TitleViewMore({required this.title,required VoidCallback ontap});
  String title;
  VoidCallback ontap = (){};

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
      child: Row(
        children: [

          Text(
            title,
            style: kTextStyle.copyWith(color: kNeutralColor, fontWeight: FontWeight.bold),
          ),

          const Spacer(),

          GestureDetector(
            onTap: () {
              ontap;
            },
            child: Text(
              'View All',
              style: kTextStyle.copyWith(color: kLightNeutralColor),
            ),
          ),

        ],
      ),
    );
  }
}
