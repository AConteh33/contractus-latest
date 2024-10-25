import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


String convertTo12HourFormat(Timestamp timestamp) {
  // Parse the input time string
  final time = timestamp.toDate().toLocal();

  // Get the hour and minute
  int hour = time.hour;
  int minute = time.minute;

  // Determine the period (am/pm)
  String period = hour >= 12 ? "PM" : "AM";

  // Convert the hour from 24-hour to 12-hour format
  if (hour == 0) {
    hour = 12;
  } else if (hour > 12) {
    hour -= 12;
  }

  // Format the minute to always have two digits
  String minuteStr = minute.toString().padLeft(2, '0');

  // Return the formatted time string
  return "$hour:$minuteStr $period";
}

String formatDate(DateTime date) {
  final DateFormat formatter = DateFormat('d MMM yyyy');
  return formatter.format(date);
}