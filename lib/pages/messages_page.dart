import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:temp_chats/classes/ChatMessage.dart';
import 'package:temp_chats/classes/MessageListContainer.dart';
import 'package:temp_chats/widgets/chat_bottom_bar.dart';
import 'package:temp_chats/widgets/chat_message_tile.dart';

class MessagesPage extends StatelessWidget {
  final MessageListContainer model;
  final String username;
  const MessagesPage(this.model, this.username) : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with $username'),
      ),
      body: Column(
        children: <Widget>[
          ScopedModel<MessageListContainer>(
            model: model,
            child: ScopedModelDescendant<MessageListContainer>(builder: (context, widget, model) =>
                Expanded(
                  child: ListView.builder(
                    itemCount: model.messages.length,
                    //shrinkWrap: true,
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    physics: AlwaysScrollableScrollPhysics(),
                    itemBuilder: (context, index) => ChatMessageTile(
                      ChatMessage(content: model.messages[index].content, received: model.messages[index].received),
                    ),
                  ),
                )
            )),

          Align(
            alignment: Alignment.bottomLeft,
            child: ChatBottomBar(),
          ),
        ],
      ),
    );
  }
}


/*
class MessagesPage extends StatefulWidget {
  final MessageListContainer container;
  const MessagesPage(this.container) : super();

  @override
  _MessagesPageState createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  //List<ChatMessage> messages = [];

  @override
  Widget build(BuildContext context) {
    //final args = ModalRoute.of(context)!.settings.arguments as ChatArgs;

    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with ${widget.container.username}'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: widget.container.messages.length,
              //shrinkWrap: true,
              padding: EdgeInsets.only(top: 10, bottom: 10),
              physics: AlwaysScrollableScrollPhysics(),
              itemBuilder: (context, index) => ChatMessageTile(
                ChatMessage(content: widget.container.messages[index].content, received: true),
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
*/
