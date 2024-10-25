import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  String chatID;
  String senderID;
  String senderName; // New variable
  String recieverID;
  String recieverName;
  String lastMessage;
  Timestamp lastMessageTime;
  List<String> participants;

  ChatModel({
    required this.chatID,
    required this.senderID,
    required this.senderName, // Include in constructor
    required this.recieverID,
    required this.recieverName,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.participants,
  });

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      chatID: map['chatID'],
      senderID: map['senderID'],
      senderName: map['senderName'], // Initialize from map
      recieverID: map['recieverID'],
      recieverName: map['recieverName'],
      lastMessage: map['lastMessage'],
      lastMessageTime: map['lastMessageTime'],
      participants: List<String>.from(map['participants'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'chatID': chatID,
      'senderID': senderID,
      'senderName': senderName, // Include in map
      'recieverID': recieverID,
      'recieverName': recieverName,
      'lastMessage': lastMessage,
      'lastMessageTime': lastMessageTime,
      'participants': participants,
    };
  }
}
