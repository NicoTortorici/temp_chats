import 'package:flutter/material.dart';
import 'package:temp_chats/classes/ChatMessage.dart';

/// Represents the graphic representation of a message.
class ChatMessageTile extends StatelessWidget {
  final ChatMessage message;

  ChatMessageTile(this.message, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
      child: Align(
        alignment: (message.received ? Alignment.topLeft : Alignment.topRight),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: (message.received ? Colors.grey.shade200 : Colors.blue[200]),
          ),
          padding: EdgeInsets.all(16),
          child: Text(
            message.content,
            style: TextStyle(fontSize: 15),
          ),
        ),
      ),
    );
  }
}
