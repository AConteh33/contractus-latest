import 'package:contractus/screen/widgets/constant.dart';
import 'package:contractus/screen/widgets/icons.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SocialLogins extends StatelessWidget {
  const SocialLogins({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SocialIcon(
            bgColor: kWhite,
            iconColor: kNeutralColor,
            icon: FontAwesomeIcons.google,
            borderColor: kBorderColorTextField,
          ),
        ],
      ),
    );
  }
}
