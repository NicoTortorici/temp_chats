import 'dart:collection';

import 'package:temp_chats/classes/ChatMessage.dart';

class MessageListContainer {
  final String username;
  final List<ChatMessage> _messages = [];

  MessageListContainer(this.username, {ChatMessage? firstMessage}) {
    if (firstMessage != null) {
      addMessage(firstMessage);
    }
  }


  UnmodifiableListView<ChatMessage> get messages {
    return UnmodifiableListView(_messages);
  }

  String get latestMessage {
    return _messages.last.content;
  }

  void addMessage(ChatMessage message) {
    _messages.add(message);
  }

}