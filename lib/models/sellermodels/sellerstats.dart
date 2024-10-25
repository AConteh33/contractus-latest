import 'package:contractus/models/sellermodels/earnings.dart';
import 'package:contractus/models/sellermodels/performance.dart';
import 'package:contractus/models/sellermodels/statistics.dart';
import 'package:flutter/material.dart';


class SellerstatModel {

  PerformanceModel performanceModel;

  EarningModel earningModel;

  StatisticModel statisticModel;
  
  SellerstatModel({
   required this.statisticModel,
   required this.earningModel,
   required this.performanceModel,
});

}