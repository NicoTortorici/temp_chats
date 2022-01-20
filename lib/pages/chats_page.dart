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
  _ChatsState createState() => _ChatsState(name: this.name);
}

class _ChatsState extends State<ChatsPage> {
  final String name;
  late ChatModel chatModel;

  _ChatsState({required this.name});

  @override
  void initState() {
    chatModel = ChatModel(name);
    chatModel.connect();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SafeArea(
              child: Padding(
                padding: EdgeInsets.only(left: 16, right: 16, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Conversations",
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding:
                          EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 2),
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.pink[50],
                      ),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.add,
                            color: Colors.pink,
                            size: 20,
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            "Add New",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
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
                                    model.messageContainers[index].username),
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
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddChatPage(chatModel))),
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}
