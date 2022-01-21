import 'package:flutter/material.dart';

class ChatBottomBar extends StatefulWidget {
  final void Function(String) onSendMessage;

  const ChatBottomBar({required this.onSendMessage, Key? key}) : super(key: key);

  @override
  State<ChatBottomBar> createState() => _ChatBottomBarState();
}

class _ChatBottomBarState extends State<ChatBottomBar> {
  final TextEditingController controller = new TextEditingController();

  void sendMessage() {
    if (controller.text != '')
      widget.onSendMessage(controller.text);
    controller.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
      height: 60,
      width: double.infinity,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 15,
          ),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                  hintText: "Message...",
                  hintStyle: TextStyle(color: Colors.black54),
                  border: InputBorder.none),
              onSubmitted: (text) => sendMessage()
            ),
          ),
          SizedBox(
            width: 15,
          ),
          FloatingActionButton(
            onPressed: sendMessage,
            child: Icon(
              Icons.send,
              color: Colors.white,
              size: 18,
            ),
            backgroundColor: Theme.of(context).primaryColor,
            elevation: 5,
          ),
        ],
      ),
    );
  }
}
