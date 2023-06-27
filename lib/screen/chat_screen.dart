import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({Key? key}) : super(key: key);
  final Stream<QuerySnapshot> _chatStream = FirebaseFirestore.instance
      .collection('chats/Jk46tLlfObiu0dE9Xq5c/messages')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FirebaseFirestore.instance
              .collection('chats/Jk46tLlfObiu0dE9Xq5c/messages')
              .add({'text': "new data"});
        },
        child: Icon(
          Icons.add,
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _chatStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final chatList = snapshot.data!.docs;
            return ListView.builder(
              itemCount: chatList.length,
              itemBuilder: (context, index) {
                final chat = chatList[index];
                return ListTile(
                  title: Text(chat['text']),
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
