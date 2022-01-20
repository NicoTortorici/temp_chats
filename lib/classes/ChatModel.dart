import 'dart:async';

import 'package:scoped_model/scoped_model.dart';
import 'package:socket_io_client/socket_io_client.dart';

import 'ChatMessage.dart';
import 'MessageListContainer.dart';

class ChatModel extends Model {
  late Socket socket;
  final String name;

  final List<MessageListContainer> messageContainers = [];

  ChatModel(this.name);

  void sendMessage(String receiverName, String content) {
    socket.emit('message', {"receiver": name, "content": content});
    notifyListeners();
  }

  MessageListContainer getMessages(String username) {
    return messageContainers.firstWhere((element) => element.username == username);
  }

  void connect() {
    socket = io("http://temp-chats.herokuapp.com/", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });

    socket.onConnectError((data) => print(data));
    socket.onConnect((data) {
      print('connected');

      socket.emit('login', name);
      Timer.periodic(Duration(seconds: 2),
          (Timer t) => sendMessage(name, 'greve zi ${t.tick}'));
    });
    socket.connect();

    // Ricevuto un messaggio
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
        container = MessageListContainer(sender, firstMessage: message);
        messageContainers.add(container);
      } else {
        container.addMessage(message);
      }

      notifyListeners();
    });
  }
}
