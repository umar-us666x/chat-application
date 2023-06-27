import 'package:chat_application/widget/bubble_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  const Message({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final chatList = snapshot.data!.docs;
          return ListView.builder(
            reverse: true,
            itemCount: chatList.length,
            itemBuilder: (context, index) {
              final chat = chatList[index];
              return BubbleMessage(
                message: chat['text'],
                isMe: chat['userId'] == FirebaseAuth.instance.currentUser!.uid,
              );
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
