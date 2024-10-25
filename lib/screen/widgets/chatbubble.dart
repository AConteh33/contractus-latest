import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contractus/controller/authcontroller.dart';
import 'package:contractus/screen/widgets/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'cards/sendoffercard.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final String name;
  final Timestamp messagetime;
  final bool isCurrentUser;
  final bool iseller;

  ChatBubble(
      {super.key,
        required this.isCurrentUser,
        required this.message,
        required this.name,
        required this.messagetime,
        required this.iseller,
      });

  String formatTimestamp(Timestamp timestamp) {
    final dateTime = timestamp.toDate().toLocal();
    final formatter = DateFormat('H:mm');
    return formatter.format(dateTime);
  }

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

  Auth_Controller authy = Auth_Controller();

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [

        message.contains('%%') ?
        SendOfferCard(
            message: message,
          iseller: iseller,
          name: name,
        ):

        Container(
          decoration: BoxDecoration(
            color: isCurrentUser ?
            kPrimaryColor : kNeutralColor,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.symmetric(
              vertical: 2.5,
              horizontal: 2.5
          ),
          child: Text(
            message,
            style: const TextStyle(color: Colors.white),
          ),
        ),

        Positioned(
          bottom: 5,
          right: 3,
          left: 3,
          child: Row(
            mainAxisAlignment:
            isCurrentUser ?
            MainAxisAlignment.end:
            MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3.0),
                child: Text(
                  convertTo12HourFormat(messagetime),
                  style: const TextStyle(
                      fontSize: 7,
                      color: Colors.white
                  ),
                ),
              ),
            ],
          ),
        ),

      ],
    );
  }
}
