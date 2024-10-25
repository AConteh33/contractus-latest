import 'package:flutter/material.dart';

class JobLocation {
  final String location;
  final double latitude;
  final double longitude;
  final int jobCount;

  JobLocation(
      this.location,
      this.latitude,
      this.longitude,
      this.jobCount);
}