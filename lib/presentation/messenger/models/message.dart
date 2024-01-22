class Message {
  final String text;
  final DateTime date;
  final bool isSendByMe;

  Message({
    required this.date,
    required this.isSendByMe,
    required this.text,
  });
}
