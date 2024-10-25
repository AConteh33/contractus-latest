import 'package:cloud_firestore/cloud_firestore.dart';

import '../../const/convertto12hourformat.dart';


class OrderModel {
  String contractid;
  String title;
  String duration;
  String description;
  String amount;
  String status;
  String seller;
  String client;
  String sellerid;
  String clientid;
  String datestr;
  Timestamp deadline;
  String category;
  String subcategory;
  Timestamp invoicedate;
  String postid;
  Timestamp createdAt;
  String postbyid;


  OrderModel({
    required this.contractid,
    required this.category,
    required this.subcategory,
    required this.sellerid,
    required this.clientid,
    required this.amount,
    required this.client,
    required this.createdAt,
    required this.datestr,
    required this.deadline,
    required this.duration,
    required this.postid,
    required this.seller,
    required this.status,
    required this.description,
    required this.title,
    required this.postbyid,
    required this.invoicedate,
  });

  // Convert OrderModel instance to a Map
  Map<String, dynamic> toMap() {
    String time = formatDate(createdAt.toDate());
    return {
      'contractid': contractid,
      'category': category,
      'subcategory': subcategory,
      'title': title,
      'duration': duration,
      'description': description,
      'amount': amount,
      'status': status,
      'seller': seller,
      'client': client,
      'sellerid': sellerid,
      'clientid': clientid,
      'datestr': time,
      'deadline': deadline,
      'invoicedate': invoicedate,
      'id': postid,
      'createdAt': createdAt,
      'postbyid': postbyid,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      contractid: map['contractid'] ?? '',
      category: map['category'] ?? '',
      subcategory: map['subcategory'] ?? '',
      title: map['title'] ?? '',
      duration: map['duration'] ?? '',
      description: map['description'] ?? '',
      amount: map['amount'],
      status: map['status'] ?? '',
      seller: map['seller'] ?? '',
      client: map['client'] ?? '',
      sellerid: map['sellerid'] ?? '',
      clientid: map['clientid'] ?? '',
      createdAt: (map['createdAt']),
      postid: map['id'] ?? '',
      postbyid: map['postbyid'] ?? '',
      deadline: (map['deadline']),
      invoicedate: (map['invoicedate']), datestr: '',
    );
  }

}