import 'package:flutter/material.dart';

class EarningModel {

  double totalearning = 0.0;
  double withdrawearning = 0.0;
  double currentbalance = 0.0;
  double activeorders = 0.0;


  EarningModel({
    required this.activeorders,
    required this.currentbalance,
    required this.totalearning,
    required this.withdrawearning,
  });

}