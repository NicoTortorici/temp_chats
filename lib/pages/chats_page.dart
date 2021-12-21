import 'package:flutter/material.dart';
import 'package:temp_chats/widgets/chat_tile.dart';
import 'package:temp_chats/widgets/curve_painter.dart';

class ChatsPage extends StatefulWidget {
  final String name;
  const ChatsPage({Key? key, required this.name}) : super(key: key);

  @override
  _ChatsState createState() => _ChatsState(name: this.name);
}

class _ChatsState extends State<ChatsPage> {
  final String name;
  _ChatsState({required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CurveWidget(
        children: [
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ChatTile(name: 'Lider', messageText: 'Sono il lider'),
                ChatTile(name: 'Lider', messageText: 'Sono il lider'),
                ChatTile(name: 'Lider', messageText: 'Sono il lider'),
                ChatTile(name: 'Lider', messageText: 'Sono il lider'),
                ChatTile(name: 'Lider', messageText: 'Sono il lider'),
                ChatTile(name: 'Lider', messageText: 'Sono il lider'),
                ChatTile(name: 'Lider', messageText: 'Sono il lider'),
              ],
            ),
          ),
        ],
      ),
      // body: CurveWidget(
      //   title: 'Chats',
      //   children: [
      //     ChatTile(name: 'Lider', messageText: 'Sono il lider'),
      //     ChatTile(name: 'Lider', messageText: 'Sono il lider'),
      //     ChatTile(name: 'Lider', messageText: 'Sono il lider'),
      //     ChatTile(name: 'Lider', messageText: 'Sono il lider'),
      //     ChatTile(name: 'Lider', messageText: 'Sono il lider'),
      //     ChatTile(name: 'Lider', messageText: 'Sono il lider'),
      //     ChatTile(name: 'Lider', messageText: 'Sono il lider'),
      //     ChatTile(name: 'Lider', messageText: 'Sono il lider'),
      //     ChatTile(name: 'Lider', messageText: 'Sono il lider'),
      //     ChatTile(name: 'Lider', messageText: 'Sono il lider'),
      //   ],
      // ),
    );
  }
}
