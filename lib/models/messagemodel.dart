import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String senderID;
  String recieverID;
  String message;
  Timestamp timestamp;

  MessageModel({
    required this.senderID,
    required this.recieverID,
    required this.message,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderID': senderID,
      'recieverID': recieverID,
      'message': message,
      'timestamp': timestamp,
    };
  }
}
