import 'package:flutter/material.dart';

import '../constant.dart';

class RoundedTopBackgorund extends StatelessWidget {
  RoundedTopBackgorund({required this.child});
  Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      child: child);
  }
}
