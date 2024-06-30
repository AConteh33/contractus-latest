import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class JobModel {
  String postid;
  String postby;
  String title;
  String desc;
  String category;
  String status;
  String datestr;
  Timestamp date;
  String id;
  LatLng location;


  JobModel({
    required this.postby,
    required this.postid,
    required this.category,
    required this.date,
    required this.datestr,
    required this.desc,
    required this.id,
    required this.status,
    required this.title,
    required this.location,
  });

}