/// Represents a message received or sent to a user.
///
/// If the message was [received], a [sender] will be provided, otherwise a
/// [receiver] will be provided.
class ChatMessage {
  final String content;
  final bool received;
  String? sender;
  String? receiver;

  ChatMessage({
    required this.content,
    required this.received,
     this.sender,
     this.receiver,
  });
}
