import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';

import '../constant.dart';

class UploadImageCard extends StatefulWidget {
  UploadImageCard({
    required this.imagefile,
  });

  String imagefile;

  @override
  State<UploadImageCard> createState() => _UploadImageCardState();
}

class _UploadImageCardState extends State<UploadImageCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Container(
        width: context.widthTransformer(),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: kBorderColorTextField),
        ),
        padding: const EdgeInsets.all(30.0),
        child: widget.imagefile == ''
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    IconlyBold.image,
                    color: kLightNeutralColor,
                    size: 50,
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    'Upload Image',
                    style: kTextStyle.copyWith(color: kSubTitleColor),
                  ),
                ],
              )
            : SizedBox(height: 200, child: Image.file(File(widget.imagefile))),
      ),
    );
  }
}
