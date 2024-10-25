import 'package:flutter/material.dart';

class ServiceLocation {
  final String location;
  final double latitude;
  final double longitude;
  final int serviceCount;

  ServiceLocation(
      this.location,
      this.latitude,
      this.longitude,
      this.serviceCount);
}