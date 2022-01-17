class ChatMessage {
  final String content;
  final bool received;
  DateTime? date;
  String? sender;
  String? receiver;

  ChatMessage({
    required this.content,
    required this.received,
    this.date,
    this.sender,
    this.receiver,
  });
}
