import 'package:flutter/material.dart';

import '../../seller screen/seller home/seller_home.dart';
import 'button_global.dart';
import '../constant.dart';

class SimpleButton extends StatelessWidget {
  SimpleButton({
    required this.title,
    required this.ontap,
    this.enabled = true,

  });

  String title;
  VoidCallback ontap;
  bool enabled;


  @override
  Widget build(BuildContext context) {
    return ButtonGlobalWithoutIcon(
        buttontext: title,
        buttonDecoration: kButtonDecoration.copyWith(
          color: enabled ? kPrimaryColor : Colors.grey[400],
          borderRadius: BorderRadius.circular(30.0),
        ),
        onPressed: ontap,
        buttonTextColor: kWhite);
  }
}
