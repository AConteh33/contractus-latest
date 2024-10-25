import 'package:flutter/foundation.dart';


class ContractModel{

  String contractId;
  DateTime createddate;
  DateTime dueDate;
  DateTime completionDate;
  String creatorid;
  String title;
  String description;
  String jobid;
  String price;
  String status;


  ContractModel({
    required this.title,
    required this.description,
    required this.price,
    required this.createddate,
    required this.creatorid,
    required this.contractId,
    required this.status,
    required this.completionDate,
    required this.dueDate,
    required this.jobid,
  });

}