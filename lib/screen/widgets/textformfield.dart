import 'package:contractus/screen/widgets/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatefulWidget {
  CustomTextFormField({
    required this.hint,
    required this.textController,
    this.inputType = TextInputType.text,
    this.formatter,
    this.maxline = 1,
  });

  String hint;
  TextEditingController textController;
  TextInputType inputType;
  int maxline;
  List<TextInputFormatter>? formatter;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: widget.textController,
        keyboardType: widget.inputType,
        cursorColor: kNeutralColor,
        textInputAction: TextInputAction.next,
        inputFormatters: widget.formatter,
        maxLines: widget.maxline,
        decoration: kInputDecoration.copyWith(
          labelText: widget.hint,
          labelStyle: kTextStyle.copyWith(
              color: kNeutralColor),
          hintText: 'Enter ${widget.hint}',
          hintStyle: kTextStyle.copyWith(
              color: kSubTitleColor),
          focusColor: kNeutralColor,
          border: const OutlineInputBorder(),
        ),
        validator: (String? value) {
          if (value!.isEmpty) {
            return 'Please enter ${widget.hint}';
          } else {
            return null;
          }
        },
      ),
    );
  }
}
