import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:temp_chats/classes/ChatModel.dart';
import 'package:temp_chats/classes/MessageListContainer.dart';
import 'package:temp_chats/pages/messages_page.dart';

class AddChatPage extends StatefulWidget {
  final ChatModel model;

  const AddChatPage(this.model, {Key? key}) : super(key: key);

  @override
  _AddChatPageState createState() => _AddChatPageState();
}

class _AddChatPageState extends State<AddChatPage> {
  final TextEditingController controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.person),
            title: TextField(
              controller: controller,
            ),
          ),

        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.send),
        onPressed: () {
          var found = widget.model.messageContainers.where((element) => element.username == controller.text);

          MessageListContainer container;
          if (found.isEmpty) {
            container = MessageListContainer(controller.text);
            widget.model.messageContainers.add(container);
          } else {
            container = found.first;
          }

          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MessagesPage(container, container.username)));
        },
      ),
    );
  }
}
