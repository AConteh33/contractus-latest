import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserTile extends StatelessWidget {
  final String recieverName;
  final String lastMessage;
  final Timestamp lastMessageTime;
  final void Function()? onTap;

  const UserTile(
      {super.key,
      required this.recieverName,
      required this.lastMessage,
      required this.lastMessageTime,
      required this.onTap}
      );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.grey,
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        recieverName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        lastMessage,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        formatTimestamp(lastMessageTime),
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              )),
          const Divider(),
        ],
      ),
    );
  }

  String formatTimestamp(Timestamp timestamp) {
    final dateTime = timestamp.toDate().toLocal();
    final formatter = DateFormat('HH:mm');
    return formatter.format(dateTime);
  }
}
