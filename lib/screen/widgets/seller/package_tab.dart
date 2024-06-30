import 'package:contractus/screen/widgets/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import '../../../models/service.dart';

class PackageTab extends StatefulWidget {
  PackageTab({required this.plansModel,required this.title});

  PlansModel plansModel;
  String title;

  @override
  State<PackageTab> createState() => _PackageTabState();
}

class _PackageTabState extends State<PackageTab> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$currencySign${widget.plansModel.price}',
            style: kTextStyle.copyWith(
                color: kNeutralColor,
                fontWeight: FontWeight.bold
            ),
          ),
          const SizedBox(height: 5.0),
          Text(
            widget.title,
            maxLines: 2,
            style: kTextStyle.copyWith(color: kNeutralColor, fontWeight: FontWeight.bold),
          ),
          // const SizedBox(height: 15.0),
          // Row(
          //   children: [
          //     const Icon(
          //       IconlyLight.timeCircle,
          //       color: kPrimaryColor,
          //       size: 18.0,
          //     ),
          //     const SizedBox(width: 5.0),
          //     Text(
          //       'Delivery days',
          //       maxLines: 1,
          //       style: kTextStyle.copyWith(color: kSubTitleColor),
          //     ),
          //     const Spacer(),
          //     Text(
          //       '${widget.plansModel.deliverydays} Days ',
          //       maxLines: 2,
          //       style: kTextStyle.copyWith(color: kNeutralColor),
          //     ),
          //   ],
          // ),
          // const SizedBox(height: 10.0),
          // Row(
          //   children: [
          //     const Icon(
          //       Icons.loop,
          //       color: kPrimaryColor,
          //       size: 18.0,
          //     ),
          //     const SizedBox(width: 5.0),
          //     Text(
          //       'Revisions',
          //       maxLines: 1,
          //       style: kTextStyle.copyWith(color: kSubTitleColor),
          //     ),
          //     const Spacer(),
          //     Text(
          //       'Unlimited',
          //       maxLines: 2,
          //       style: kTextStyle.copyWith(color: kNeutralColor),
          //     ),
          //   ],
          // ),
          // const SizedBox(height: 15.0),
          // const Divider(
          //   height: 0,
          //   thickness: 1.0,
          //   color: kBorderColorTextField,
          // ),
          // const SizedBox(height: 15.0),
          // Row(
          //   children: [
          //     Text(
          //       '3 Page/Screen',
          //       maxLines: 1,
          //       style: kTextStyle.copyWith(color: kNeutralColor),
          //     ),
          //     const Spacer(),
          //     const Icon(
          //       Icons.check_rounded,
          //       color: kPrimaryColor,
          //     ),
          //   ],
          // ),
          // const SizedBox(height: 5.0),
          // Row(
          //   children: [
          //     Text(
          //       '2 Custom assets',
          //       maxLines: 1,
          //       style: kTextStyle.copyWith(color: kSubTitleColor),
          //     ),
          //     const Spacer(),
          //     const Icon(
          //       Icons.check_rounded,
          //       color: kPrimaryColor,
          //     ),
          //   ],
          // ),
          // const SizedBox(height: 5.0),
          // Row(
          //   children: [
          //     Text(
          //       'Responsive design',
          //       maxLines: 1,
          //       style: kTextStyle.copyWith(color: kNeutralColor),
          //     ),
          //     const Spacer(),
          //     const Icon(
          //       Icons.check_rounded,
          //       color: kPrimaryColor,
          //     ),
          //   ],
          // ),
          // const SizedBox(height: 5.0),
          // Row(
          //   children: [
          //     Text(
          //       'Prototype',
          //       maxLines: 1,
          //       style: kTextStyle.copyWith(color: kSubTitleColor),
          //     ),
          //     const Spacer(),
          //     const Icon(
          //       Icons.check_rounded,
          //       color: kPrimaryColor,
          //     ),
          //   ],
          // ),
          // const SizedBox(height: 5.0),
          // Row(
          //   children: [
          //     Text(
          //       'Source file',
          //       maxLines: 1,
          //       style: kTextStyle.copyWith(color: kNeutralColor),
          //     ),
          //     const Spacer(),
          //     const Icon(
          //       Icons.check_rounded,
          //       color: kPrimaryColor,
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
