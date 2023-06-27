import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  String _message = '';

// CONTROLLER ketika pesan sudah dikirim text ditextfield hilang otomatis
  final messageController = TextEditingController();

// FUNCTION ketika pesan kosong icon send tidak berfungsi
  void _sendMessage() async {
    if (_message == '') {
      return;
    }

    final user = await FirebaseAuth.instance.currentUser;

    FirebaseFirestore.instance.collection('chat').add({
      'text': _message,
      'createdAt': Timestamp.now(),
      'userId': user!.uid,
    });
    messageController.clear();
    _message = '';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: messageController,
              onChanged: (value) {
                setState(() {
                  _message = value;
                });
              },
            ),
          ),
          IconButton(
            onPressed: _sendMessage,
            icon: Icon(
              Icons.send,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}
