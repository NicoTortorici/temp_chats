import 'package:flutter/material.dart';

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
      body: Container(
        child: Text(name),
      ),
    );
  }
}
