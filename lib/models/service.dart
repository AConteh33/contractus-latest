import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ServiceModel {
  String postid;
  String postedby;
  String address;
  LatLng location;
  List imageurls;
  String title;
  String rating;
  String ratingcount;
  String price;
  String name;
  String level;
  String image;
  bool favorite;
  String details;
  PlansModel basic;
  PlansModel standard;
  PlansModel premium;
  int likes;

  ServiceModel({
    required this.postid,
    required this.location,
    required this.imageurls,
    required this.address,
    required this.rating,
    required this.postedby,
    required this.level,
    required this.image,
    required this.title,
    required this.price,
    required this.favorite,
    required this.name,
    required this.ratingcount,
    required this.details,
    required this.basic,
    required this.standard,
    required this.premium,
    this.likes = 0,
  });

}

class PlansModel {

  String price;

  String deliverydays;
  String revisions;
  Map<String,String> extra;


  PlansModel({
    required this.price,
    required this.deliverydays,
    required this.extra,
    required this.revisions,
  });
}