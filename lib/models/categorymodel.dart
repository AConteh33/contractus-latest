import 'package:flutter/material.dart';

class CategoryModel {
  // IconData icon;
  String category;
  List<String> subcategory;

  var icon;

  CategoryModel({
    required this.category,
    required this.subcategory,
    required this.icon,
    // required this.icon,
  });
}
