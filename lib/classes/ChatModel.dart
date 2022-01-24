import 'package:scoped_model/scoped_model.dart';
import 'package:socket_io_client/socket_io_client.dart';

import 'ChatMessage.dart';
import 'MessageListContainer.dart';

class ChatModel extends Model {
  late Socket socket; // will be set later
  late String name;

  final List<MessageListContainer> messageContainers = [];

  /// Sends a message to the [receiverName].
  void sendMessage(String receiverName, String content) {
    socket.emit('message', {"receiver": receiverName, "content": content});
    notifyListeners();
  }

  /// Gets all messages with the user [username].
  MessageListContainer getMessages(String username) {
    return messageContainers.firstWhere((element) => element.username == username);
  }

  /// Sets up the [socket] so that it can receive messages.
  void listenToMessages(Socket socket) {
    socket.on('message', (args) {
      String sender = args['sender'];
      String content = args['content'];

      var message = ChatMessage(
          content: content, received: true, sender: sender, receiver: name);

      // Searches for the message container to see if the user already started
      // the conversation.
      var containers = messageContainers.where((element) => element.username == sender);
      MessageListContainer? container = containers.isEmpty ? null : containers.first;

      if (container == null) {
        container = MessageListContainer(sender, this, firstMessage: message);
        messageContainers.add(container);
      } else {
        container.addMessage(message);
      }

      // Notifies all listeners that a new message has been added.
      notifyListeners();
    });
  }

  /// Logs in the client with the provided [name] and calls the [loginAck] once
  /// the login has completed.
  ///
  /// If the login was successful, the parameter of loginAck will be null;
  /// otherwise, the error received from the server will be provided.
  Socket login(String name, Function(String?) loginAck)  {
    this.name = name;

    socket = io("https://temp-chats.herokuapp.com/", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });

    socket.onConnectError((data) => print(data));
    socket.onConnect((data) {
      print('connected');

      // Get ready to receive the ack message from the server.
      socket.on('login', (msg) {
        if (msg == 'ok')
          msg = null;
        loginAck(msg);
      });

      // Send the log in message.
      socket.emit('login', name);

    });
    socket.connect();

    listenToMessages(socket); // register events for handling messages.

    return socket;
  }
}
