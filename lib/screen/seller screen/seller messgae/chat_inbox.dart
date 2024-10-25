import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contractus/controller/authcontroller.dart';
import 'package:contractus/controller/chatcontroller.dart';
import 'package:contractus/models/sellermodels/ordermodel.dart';
import 'package:contractus/screen/generatecontract.dart';
import 'package:contractus/screen/widgets/chatbubble.dart';
import 'package:contractus/screen/widgets/constant.dart';
import 'package:contractus/screen/widgets/textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatInbox extends StatefulWidget {
  final String chatRoomID;
  final String recieverName;
  final String recieverID;
  final bool iseller;
  const ChatInbox(
      {super.key, required this.recieverName,
        required this.recieverID,required this.iseller,required this.chatRoomID});

  @override
  State<ChatInbox> createState() => _ChatInboxState();

}

class _ChatInboxState extends State<ChatInbox> {

  final TextEditingController _messageController = TextEditingController();

  final ScrollController _scrollController = ScrollController();

  ChatController chatController = ChatController();

  Auth_Controller authy = Get.put(Auth_Controller());

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // FOCUS NODE
  FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    _messageController.dispose();
    super.dispose();
  }

  // SCROLL DOWN METHOD
  void scrollDown() {
    _scrollController.animateTo(0,
        duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
  }

  // SEND MESSAGE
  void sendMessage() async {

    if (_messageController.text.isNotEmpty) {

      await chatController.sendMessage(
        chatRoomID: widget.chatRoomID,
          recieverID: widget.recieverID,
          message: _messageController.text,
          recieverName: widget.recieverName,
          senderName: authy.authData.value!.name,
      );

      _messageController.clear();

    }

    scrollDown();

  }

  void sendOffer({required String id,required String chatroom}) async {

      await chatController.sendOffer(
        recieverID: widget.recieverID,
        chatRoomID: chatroom,
        recieverName: widget.recieverName,
        senderName: authy.authData.value!.name, message: id,
      );

    scrollDown();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recieverName),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          // displaying messages
          Expanded(
            child: _buildMessageList(),
          ),

          //user input
          _buildMessageInput(),
        ],
      ),
    );
  }

  // Message list
  Widget _buildMessageList() {

    String currentUserID = _auth.currentUser!.uid;

    return StreamBuilder(
        stream: chatController.getMessages(widget.chatRoomID),
        builder: (context, snapshot) {

          if (snapshot.hasError) {
            return const Text("Error");
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading...");
          }

          return ListView(
            controller: _scrollController,
            reverse: true,
            children: snapshot.data!.docs
                .map((doc) => _buildMessageItem(doc))
                .toList(),
          );

        });
  }

  // build message item
  Widget _buildMessageItem(DocumentSnapshot doc) {

    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    bool isCurrentUser = data['senderID'] == _auth.currentUser!.uid;

    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return  Container(
        alignment: alignment,
        child: Column(
          crossAxisAlignment:
              isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            ChatBubble(
              name: '',
              message: data["message"],
              isCurrentUser: isCurrentUser,
              messagetime: data["timestamp"],
              iseller: widget.iseller,
            ),
          ],
        )
    );
  }

  // build message input
  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0,top: 10.0,),
      child: Row(
        children: [

          widget.iseller ? const SizedBox()
              : Container(
            decoration: const BoxDecoration(
              color: kPrimaryColor,
              shape: BoxShape.circle,
            ),
            margin: const EdgeInsets.only(left: 10,),
            child: IconButton(
              onPressed: () async {

                String newContract = await Get.to(
                    GenerateContract(
                      postid: '',
                      sellerid: widget.recieverID,
                    )
                );

                sendOffer(
                    id: newContract, chatroom: widget.chatRoomID,
                );

              },
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),

          // text input
          Expanded(
              child: MyTextField(
            controller: _messageController,
            hintText: "Type a message",
            obsecureText: false,
          )),

          // Send button
          Container(
            decoration: const BoxDecoration(
              color: kPrimaryColor,
              shape: BoxShape.circle,
            ),
            margin: const EdgeInsets.only(right: 10,),
            child: IconButton(
              onPressed: sendMessage,
              icon: const Icon(
                Icons.arrow_upward,
                color: Colors.white,
              ),
            ),
          ),

        ],
      ),
    );
  }
}
