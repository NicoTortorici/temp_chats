import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:temp_chats/classes/ChatMessage.dart';
import 'package:temp_chats/classes/MessageListContainer.dart';
import 'package:temp_chats/widgets/chat_bottom_bar.dart';
import 'package:temp_chats/widgets/chat_message_tile.dart';

class MessagesPage extends StatelessWidget {
  final MessageListContainer model;
  final String username;

  final ScrollController controller = new ScrollController();

  MessagesPage(this.model, this.username) : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with $username'),
      ),
      body: Column(
        children: <Widget>[
          ScopedModel<MessageListContainer>(
            // The model is passed through constructor.
            model: model,
            child: ScopedModelDescendant<MessageListContainer>(
              // This is the function that will be used to rebuild the components.
              builder: (context, widget, model) {
                // This is used to scroll to the latest message when this is rebuilt.
                WidgetsBinding.instance!.addPostFrameCallback((_) =>
                    controller.animateTo(controller.position.maxScrollExtent,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeOut));

                return Expanded(
                  child: ListView.builder(
                    itemCount: model.messages.length,
                    controller: controller,
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    physics: AlwaysScrollableScrollPhysics(),
                    itemBuilder: (context, index) => ChatMessageTile(
                      ChatMessage(
                          content: model.messages[index].content,
                          received: model.messages[index].received),
                    ),
                  ),
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: ChatBottomBar(onSendMessage: (msg) {
              model.sendMessage(msg);
            }),
          ),
        ],
      ),
    );
  }
}
