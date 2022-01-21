import 'package:flutter/material.dart';
import 'package:temp_chats/pages/chats_page.dart';
import 'package:temp_chats/pages/login_page.dart';
import 'package:temp_chats/pages/messages_page.dart';

void main() {
  runApp(ChatApp());
}

class ChatApp extends StatefulWidget {
  const ChatApp({Key? key}) : super(key: key);

  @override
  _ChatAppState createState() => _ChatAppState();
}

class _ChatAppState extends State<ChatApp> {
  String _name = '';
  //late ChatModel _model;

  void _setName(String name) {
    setState(() {
      _name = name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //routerDelegate: _appRouter.delegate(),

      //routeInformationParser: _appRouter.defaultRouterParser(),
      routes: {
        '/login': (ctx) => LoginPage(
              setName: _setName,
            ),
        '/chats': (ctx) => ChatsPage(name: _name),
        //'/chat': (ctx) => MessagesPage()
      },
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.indigo, accentColor: Colors.deepPurpleAccent),
      //home: LoginPage(),
      initialRoute: '/login',
    );
  }
}
