import 'package:contractus/models/sellermodels/earnings.dart';
import 'package:contractus/models/sellermodels/performance.dart';
import 'package:contractus/models/sellermodels/statistics.dart';
import 'package:flutter/material.dart';


class SellerstatModel {

  PerformanceModel performanceModel = PerformanceModel(
      ontimedelivery: '0', orderscomplete: '0',
      positiverating: '0.0', totalgig: '0 of 0');

  EarningModel earningModel = EarningModel(
      activeorders: 0.0, currentbalance: 0.0,
      totalearning: 0.0, withdrawearning: 0.0);

  StatisticModel statisticModel = StatisticModel(impressions: 0.0, interaction: 0.0, reachedout: 0.0);
  
  SellerstatModel({
   required this.statisticModel,
   required this.earningModel,
   required this.performanceModel,
});

}