import 'package:contractus/screen/widgets/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingWidget extends StatelessWidget {
  LoadingWidget({
    required this.child,
    required this.isloading
  });

  Widget child;
  bool isloading;

  @override
  Widget build(BuildContext context) {
    return Stack(
          children: [

            isloading ? Positioned(
              right: 0,
              left: 0,
              top: 0,
              bottom: 0,
              child: Center(
                child: LoadingAnimationWidget.threeArchedCircle(
                  color: kPrimaryColor,
                  size: 50,
                ),
              ),
            ): const SizedBox(),
            child,
          ],
        );
  }
}
