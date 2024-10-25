import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class JobModel {
  String postid;
  String postby;
  String title;
  String desc;
  String paymentrate;
  String estduration;
  String category;
  String subcategory;
  String status;
  String datestr;
  Timestamp date;
  LatLng location;
  String address;


  JobModel({
    required this.postby,
    required this.postid,
    required this.category,
    required this.subcategory,
    required this.date,
    required this.datestr,
    required this.desc,
    required this.estduration,
    required this.status,
    required this.paymentrate,
    required this.title,
    required this.location,
    required this.address,
  });

}