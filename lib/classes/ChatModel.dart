import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:socket_io_client/socket_io_client.dart';

import 'ChatMessage.dart';
import 'MessageListContainer.dart';

class ChatModel extends Model {
  //bool mustScroll = false;
  late Socket socket;
  late String name;

  final List<MessageListContainer> messageContainers = [];

  //ChatModel(this.name);

  void sendMessage(String receiverName, String content) {
    socket.emit('message', {"receiver": receiverName, "content": content});
    notifyListeners();
  }

  MessageListContainer getMessages(String username) {
    return messageContainers.firstWhere((element) => element.username == username);
  }

  void listenToMessages(Socket socket) {
    socket.on('message', (args) {
      print(args);
      String sender = args['sender'];
      String content = args['content'];

      var containers =
      messageContainers.where((element) => element.username == sender);
      MessageListContainer? container =
      containers.isEmpty ? null : containers.first;

      var message = ChatMessage(
          content: content, received: true, sender: sender, receiver: name);
      if (container == null) {
        container = MessageListContainer(sender, this, firstMessage: message);
        messageContainers.add(container);
      } else {
        container.addMessage(message);
      }

      notifyListeners();
    });
  }

  Socket login(String name, Function(String?) loginAck)  {
    this.name = name;

    socket = io("https://temp-chats.herokuapp.com/", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });

    socket.onConnectError((data) => print(data));
    socket.onConnect((data) {
      print('connected');

      socket.on('login', (msg) {
        if (msg == 'ok')
          msg = null;
        loginAck(msg);
      });
      socket.emit('login', name);

    });
    socket.connect();

    listenToMessages(socket);
    // Ricevuto un messaggio

    return socket;
  }
}
