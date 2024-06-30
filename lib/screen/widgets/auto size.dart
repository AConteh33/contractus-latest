import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'constant.dart';

class PreAutoSizeText extends StatefulWidget {
  PreAutoSizeText({required this.txt,required this.styling});
  String txt;
  TextStyle styling;

  @override
  State<PreAutoSizeText> createState() => _PreAutoSizeTextState();
}

class _PreAutoSizeTextState extends State<PreAutoSizeText> {
  @override
  Widget build(BuildContext context) {

    return AutoSizeText(
      widget.txt,
      presetFontSizes: [13, 10, 8],
      maxLines: 4,
      style: widget.styling,
    );

  }
}
