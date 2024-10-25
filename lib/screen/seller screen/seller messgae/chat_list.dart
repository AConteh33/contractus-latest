import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contractus/controller/authcontroller.dart';
import 'package:contractus/controller/chatcontroller.dart';
import 'package:contractus/models/chatmodel.dart';
import 'package:contractus/screen/seller%20screen/seller%20messgae/chat_inbox.dart';
import 'package:contractus/screen/seller%20screen/seller%20messgae/userTile.dart';
import 'package:contractus/screen/widgets/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
  }

  Auth_Controller authy = Get.put(Auth_Controller());

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  final ChatController chatController = ChatController();
  final String currentUserID = FirebaseAuth.instance.currentUser!.uid;
  RxList<ChatModel> chatsList = <ChatModel>[].obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkWhite,
      appBar: AppBar(
        title: Text(
          'Messages',
          style: kTextStyle.copyWith(
              color: kNeutralColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: kDarkWhite,
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
        decoration: const BoxDecoration(
          color: kWhite,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
        ),
        child: _buildChatsList(),
      ),
    );
  }

  Widget _buildChatsList() {

    return StreamBuilder(
        stream: chatController.getUserChatsList(),
        builder: (context, snapshot) {

          if (snapshot.hasError) {
            return const Text("Error");
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData) {
            // Handle no data scenario (optional)
            return const Center(child: Text("No chats found"));
          }

          return ListView(
            children: snapshot.data!
                .map<Widget>(
                    (chatData)
                => _buildChatsListItem(chatData, context)
            ).toList(),
          );

        });

  }

  Widget _buildChatsListItem(
      Map<String, dynamic> chatData, BuildContext context) {

    bool Iseller = 'iseller' == authy.authData.value!.role;

    return FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('users')
            .doc(
            Iseller ?
            chatData['senderID']:
            chatData['recieverID']

        ).get(),
        builder: (context,snapshot) {

        return UserTile(
          onTap: () {

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChatInbox(
                        recieverName: chatData["recieverName"],
                        recieverID: chatData["recieverID"],
                      iseller: authy.authData.value!.role == 'seller',
                      chatRoomID: chatData["chatID"],
                    )
                )
            );

          },
          recieverName: snapshot.data?['name'],
          lastMessage: chatData["lastMessage"].contains('%%') ?
          '(Offer has been Sent)' : chatData["lastMessage"],
          lastMessageTime: chatData["lastMessageTime"],
        );
      }
    );
  }
}
