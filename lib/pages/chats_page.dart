import 'dart:async';

import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:temp_chats/classes/ChatMessage.dart';
import 'package:temp_chats/classes/MessageListContainer.dart';
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
  late Socket socket;
  final List<MessageListContainer> messageContainers = [];

  _ChatsState({required this.name});

  void sendMessage(String receiverName, String content) {
    socket.emit('message', {"receiver": name, "content": content });
  }

  @override
  void initState() {

    socket = io("http://temp-chats.herokuapp.com/", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });

    socket.onConnectError((data) => print(data));
    socket.onConnect((data) {
        print('connected');

        socket.emit('login', name);
        Timer.periodic(Duration(seconds: 2), (Timer t) => sendMessage(name, 'greve zi ${t.tick}'));
    });
    socket.connect();


    // Ricevuto un messaggio
    socket.on('message', (args) {
      print(args);
      setState(() {
        String sender = args['sender'];
        String content = args['content'];

        var containers =
            messageContainers.where((element) => element.username == sender);
        MessageListContainer? container =
            containers.isEmpty ? null : containers.first;

        var message = ChatMessage(
            content: content, received: true, sender: sender, receiver: name);
        if (container == null) {
          container = MessageListContainer(sender, firstMessage: message);
          messageContainers.add(container);
        } else {
          container.addMessage(message);
        }


      });
    });


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
            ListView.builder(
              itemCount: messageContainers.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 16),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return ChatTile(
                  name: messageContainers[index].username,
                  messageText: messageContainers[index].latestMessage,
                  action: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => MessagesPage(messageContainers[index])),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
