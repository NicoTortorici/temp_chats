import 'dart:collection';

import 'package:scoped_model/scoped_model.dart';
import 'package:temp_chats/classes/ChatMessage.dart';

import 'ChatModel.dart';

class MessageListContainer extends Model {
  final String username;
  final List<ChatMessage> _messages = [];
  final ChatModel _model;

  MessageListContainer(this.username, this._model, {ChatMessage? firstMessage}) {
    if (firstMessage != null) {
      addMessage(firstMessage);
    }
  }

  void
  sendMessage(String msg) {
    addMessage(ChatMessage(content: msg, received: false, receiver: username));
    _model.sendMessage(username, msg);
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