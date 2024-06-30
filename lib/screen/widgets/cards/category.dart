import 'package:contractus/models/category.dart';
import 'package:contractus/screen/client%20screen/client%20home/client_category_screen.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../models/categorymodel.dart';
import '../constant.dart';

class CategoryCard extends StatefulWidget {
  CategoryCard({required this.category});
  CategoryModel category;

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ClientCategoryScreen(
          titlecategory: widget.category.category,
        ).launch(context);
      },
      child: Container(
        padding: const EdgeInsets.only(
            left: 5.0, right: 10.0, top: 5.0, bottom: 5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: kWhite,
          boxShadow: const [
            BoxShadow(
              color: kBorderColorTextField,
              blurRadius: 7.0,
              spreadRadius: 1.0,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 39,
              width: 39,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Icon(
                widget.category.icon,
                size: 30.0,

              ),
            ),
            const SizedBox(width: 3.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.category.category,
                  style: kTextStyle.copyWith(
                      color: kNeutralColor, fontWeight: FontWeight.bold,),
                ),
                const SizedBox(height: 2.0),
                Text(
                  'Related all categories',
                  style: kTextStyle.copyWith(color: kLightNeutralColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
