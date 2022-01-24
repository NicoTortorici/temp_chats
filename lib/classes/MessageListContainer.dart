import 'dart:collection';

import 'package:scoped_model/scoped_model.dart';
import 'package:temp_chats/classes/ChatMessage.dart';

import 'ChatModel.dart';

/// Represents a conversation with another user [username].
///
/// A conversation is made up of [messages].
class MessageListContainer extends Model {
  final String _username;

  final List<ChatMessage> _messages = [];
  final ChatModel _model;

  MessageListContainer(this._username, this._model,
      {ChatMessage? firstMessage}) {

    if (firstMessage != null)
      addMessage(firstMessage);
  }

  /// Sends a message [msg] to [username].
  void sendMessage(String msg) {
    addMessage(ChatMessage(content: msg, received: false, receiver: username));
    _model.sendMessage(username, msg);
  }

  /// The user this conversation is with.
  String get username => _username;

  /// All the messages to and from [username].
  UnmodifiableListView<ChatMessage> get messages {
    return UnmodifiableListView(_messages);
  }

  /// The content of the latest message with [username].
  String get latestMessage {
    if (_messages.isEmpty) return '';
    return _messages.last.content;
  }

  /// Adds a new message to this conversation.
  void addMessage(ChatMessage message) {
    _messages.add(message);
    notifyListeners();
  }
}
