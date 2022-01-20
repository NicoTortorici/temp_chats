import 'dart:collection';

import 'package:scoped_model/scoped_model.dart';
import 'package:temp_chats/classes/ChatMessage.dart';

class MessageListContainer extends Model {
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
    if (_messages.isEmpty) return '';
    return _messages.last.content;
  }

  void addMessage(ChatMessage message) {
    _messages.add(message);
    notifyListeners();
  }

}