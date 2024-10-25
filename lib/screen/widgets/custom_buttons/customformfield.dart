import 'package:flutter/material.dart';

import '../constant.dart';

class CustomFormField extends StatefulWidget {
  CustomFormField({required this.child,required this.title});
  Widget child;
  String title;

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  @override
  Widget build(BuildContext context) {
    return FormField(
      builder: (FormFieldState<dynamic> field) {
        return InputDecorator(
          decoration: kInputDecoration.copyWith(
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
              borderSide: BorderSide(
                  color: kBorderColorTextField, width: 2),
            ),
            contentPadding: const EdgeInsets.all(7.0),
            floatingLabelBehavior:
            FloatingLabelBehavior.always,
            labelText: widget.title,
            labelStyle:
            kTextStyle.copyWith(color: kNeutralColor),
          ),
          child: DropdownButtonHideUnderline(
              child: widget.child),
        );
      },
    );
  }
}
