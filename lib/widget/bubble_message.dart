import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BubbleMessage extends StatelessWidget {
  BubbleMessage({Key? key, required this.message, required this.isMe})
      : super(key: key);

  String message;
  bool isMe;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          width: 150,
          padding: EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 8,
          ),
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: isMe ? Colors.blue : Colors.grey[400],
          ),
          child: Text(
            message,
            style: TextStyle(
              color: isMe ? Colors.white : Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
