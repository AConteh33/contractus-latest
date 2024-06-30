import 'package:cloud_firestore/cloud_firestore.dart';


class OrderModel {
  String title;
  String duration;
  String amount;
  String status;
  String seller;
  String client;
  String datestr;
  Timestamp deadline;
  String id;
  Timestamp createdAt;
  String postbyid;


  OrderModel({
    required this.amount,
    required this.client,
    required this.createdAt,
    required this.datestr,
    required this.deadline,
    required this.duration,
    required this.id,
    required this.seller,
    required this.status,
    required this.title,
    required this.postbyid,
  });

}