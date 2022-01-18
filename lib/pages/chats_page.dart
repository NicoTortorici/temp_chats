import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:temp_chats/widgets/chat_tile.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatsPage extends StatefulWidget {
  final String name;

  const ChatsPage({Key? key, required this.name}) : super(key: key);

  @override
  _ChatsState createState() => _ChatsState(name: this.name);
}

class _ChatsState extends State<ChatsPage> {
  final String name;
  late Socket socket;

  _ChatsState({required this.name});

  @override
  void initState() {
    super.initState();

    socket = io("http://127.0.0.1:6969/", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket.on('connect', (data) {
      print(socket.connected);
    });

    socket.connect();
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
              itemCount: 10,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 16),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return ChatTile(
                  name: "Lider",
                  messageText: "Sono il lider",
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
