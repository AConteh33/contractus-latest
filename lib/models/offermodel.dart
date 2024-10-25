import 'package:flutter/material.dart';


class OfferModel {
  String offerid;
  DateTime createddate;
  String creatorid;
  String title;
  String description;
  String price;
  int duration;

  OfferModel({
    required this.title,
    required this.description,
    required this.price,
    required this.createddate,
    required this.creatorid,
    required this.offerid,
    required this.duration,
});


}