import 'package:flutter/material.dart';

import '../constant.dart';
import '../data.dart';

class LevelSelection extends StatefulWidget {
  const LevelSelection({super.key});

  @override
  State<LevelSelection> createState() => _LevelSelectionState();
}

class _LevelSelectionState extends State<LevelSelection> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        initiallyExpanded: true,
        tilePadding: EdgeInsets.zero,
        childrenPadding: EdgeInsets.zero,
        collapsedIconColor: kLightNeutralColor,
        iconColor: kLightNeutralColor,
        title: Text(
          'Reach Your Next Level',
          style: kTextStyle.copyWith(color: kNeutralColor, fontWeight: FontWeight.bold),
        ),
        children: const [
          LevelSummary(
            title: 'Level 1',
            subTitle: 'Receive and complete at least 30 orders (all time)',
            trailing1: '20',
            trailing2: '30',
          ),
          SizedBox(height: 15.0),
          LevelSummary(
            title: 'Level 2',
            subTitle: 'Receive and complete at least 30 orders (all time)',
            trailing1: '0',
            trailing2: '70',
          ),
          SizedBox(height: 15.0),
          LevelSummary(
            title: 'Level 3',
            subTitle: 'Receive and complete at least 30 orders (all time)',
            trailing1: '0',
            trailing2: '120',
          ),
        ],
      ),
    );
  }
}
