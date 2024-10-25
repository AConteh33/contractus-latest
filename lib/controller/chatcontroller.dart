import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contractus/controller/authcontroller.dart';
import 'package:contractus/models/chatmodel.dart';
import 'package:contractus/models/messagemodel.dart';
import 'package:contractus/screen/seller%20screen/seller%20messgae/chat_inbox.dart';
import 'package:contractus/screen/seller%20screen/seller%20messgae/userTile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Auth_Controller authController = Auth_Controller();

  var chatsList = <ChatModel>[].obs;
  var userNames = <String, String>{}.obs; // Map to store user IDs and their names

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchChats();
  }

  void fetchChats() async {
    final String currentUserID = _auth.currentUser!.uid;

    var chatsSnapshot = await _firestore
        .collection('chats')
        .where('participants', arrayContains: currentUserID)
        .get();

    var chats = chatsSnapshot.docs
        .map((doc) => ChatModel.fromMap(doc.data()))
        .toList();
    chatsList.assignAll(chats);

    for (var chat in chats) {
      String otherUserID =
      chat.senderID == currentUserID ? chat.recieverID : chat.senderID;
      var userSnapshot =
      await _firestore.collection('users').doc(otherUserID).get();
      userNames[otherUserID] = userSnapshot['name'];
    }

  }

  // Creating a Chat Room
  Future<String> createChatRoom({
    required String recieverID,
    required String message,
    required String recieverName,
    required String senderName,
    required Timestamp timestamp
  }) async {

    final String currentUserID = _auth.currentUser!.uid;

    List<String> ids = [currentUserID, recieverID];

    ids.sort();

    String chatRoomID = ids.join('_');

    ChatModel newChatRoom = ChatModel(
        chatID: chatRoomID,
        senderID: currentUserID,
        recieverID: recieverID,
        recieverName: recieverName,
        lastMessage: message,
        lastMessageTime: timestamp,
        participants: ids, senderName: senderName);

    await _firestore
        .collection("chats")
        .doc(chatRoomID)
        .set(newChatRoom.toMap());

    return chatRoomID;

  }


  // Creating a Chat Room
  Future<void> updateChatRoom({
      required String chatRoomID,
      required String message,
      required Timestamp timestamp}) async {


    await _firestore
        .collection("chats")
        .doc(chatRoomID)
        .update({
      'lastMessage': message,
      'lastMessageTime': timestamp,
    });

  }

  // SENDING A MESSAGE
  Future<void> sendMessage({
    required String recieverID,
    message,
    recieverName,
    senderName,
    chatRoomID
  }) async {

    final String currentUserID = _auth.currentUser!.uid;

    final Timestamp timestamp = Timestamp.now();

    // createChatRoom(recieverID, message, recieverName,senderName ,timestamp);

    updateChatRoom(
        chatRoomID: chatRoomID,
        message: message,
        timestamp: timestamp,
    );

    // create a new message
    MessageModel newMessage = MessageModel(
        senderID: currentUserID,
        recieverID: recieverID,
        message: message,
        timestamp: timestamp,
    );

    await _firestore
        .collection("chats")
        .doc(chatRoomID)
        .collection("messages")
        .add(newMessage.toMap());

  }

  // SENDING A OFFER
  Future<void> sendOffer({required String recieverID,
    required String message,
    recieverName,senderName,required String chatRoomID}) async {

    final String currentUserID = _auth.currentUser!.uid;
    final Timestamp timestamp = Timestamp.now();

    // createChatRoom(recieverID, '%%$message' , recieverName,senderName , timestamp);
    updateChatRoom(chatRoomID: chatRoomID, message: '%%$message', timestamp: timestamp);

    // chat room id
    List<String> ids = [currentUserID, recieverID];
    ids.sort();

    // create a new message

    MessageModel newMessage = MessageModel(
        senderID: currentUserID,
        recieverID: recieverID,
        message: '%%$message',
        timestamp: timestamp
    );

    await _firestore
        .collection("chats")
        .doc(chatRoomID)
        .collection("messages")
        .add(newMessage.toMap());

  }

  // GET MESSAGES
  Stream<QuerySnapshot> getMessages(String chatRoomID) {

    // List<String> ids = [currentUserID, recieverID];
    // ids.sort();
    // String chatRoomID = ids.join('_');

    return _firestore
        .collection("chats")
        .doc(chatRoomID)
        .collection('messages')
        .orderBy("timestamp",descending: true)
        .snapshots();

  }

  // adding a new chat to the list

  addChatToList(RxList<ChatModel> chatList, ChatModel newChat) {
    chatList.add(newChat);
  }

  // getting the filtered chats list for every user

  Stream<List<Map<String, dynamic>>> getUserChatsList() {
    final String currentUserID = _auth.currentUser!.uid;

    return _firestore
        .collection("chats")
        .where('participants', arrayContains: currentUserID)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final chats = doc.data();

        return chats;
      }).toList();
    });
  }

}
