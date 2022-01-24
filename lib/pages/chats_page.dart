import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:temp_chats/classes/ChatModel.dart';
import 'package:temp_chats/pages/add_chat_page.dart';
import 'package:temp_chats/pages/messages_page.dart';
import 'package:temp_chats/widgets/chat_tile.dart';

class ChatsPage extends StatefulWidget {
  final String name;

  const ChatsPage({Key? key, required this.name}) : super(key: key);

  @override
  _ChatsState createState() => _ChatsState();
}

class _ChatsState extends State<ChatsPage> {
  late ChatModel chatModel;

  _ChatsState();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // chatModel is passed as argument of the route.
    chatModel = ModalRoute.of(context)!.settings.arguments as ChatModel;

    // Used to check if the chat is being closed. If it is, disconnect the socket.
    return WillPopScope(
      onWillPop: () async {
        chatModel.socket.disconnect();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(title: Text("Your Chats, ${chatModel.name}")),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Used to listen for changes on the ChatModel.
              ScopedModel<ChatModel>(
                model: chatModel,
                child: ScopedModelDescendant<ChatModel>(
                    builder: (context, widget, model) {
                  return ListView.builder(
                    itemCount: model.messageContainers.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.only(top: 16),
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ChatTile(
                        name: model.messageContainers[index].username,
                        messageText:
                            model.messageContainers[index].latestMessage,
                        action: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => MessagesPage(
                                model.messageContainers[index],
                                model.messageContainers[index].username
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => AddChatPage(chatModel))),
          backgroundColor: Theme.of(context).primaryColor,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
