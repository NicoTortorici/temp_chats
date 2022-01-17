import 'package:flutter/material.dart';
import 'package:temp_chats/classes/ChatArguments.dart';
import 'package:temp_chats/classes/ChatMessage.dart';
import 'package:temp_chats/widgets/chat_bottom_bar.dart';
import 'package:temp_chats/widgets/chat_message_tile.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({Key? key}) : super(key: key);

  @override
  _MessagesPageState createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  List<ChatMessage> messages = [];

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ChatArgs;

    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with ${args.name}'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              //shrinkWrap: true,
              padding: EdgeInsets.only(top: 10, bottom: 10),
              physics: AlwaysScrollableScrollPhysics(),
              itemBuilder: (context, index) => ChatMessageTile(
                ChatMessage(content: 'Lider', received: true),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: ChatBottomBar(),
          ),
        ],
      ),
    );
  }
}
