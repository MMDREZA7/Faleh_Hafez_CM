class MessageDTO {
  final String reciverID;
  final String text;
  final String token;

  MessageDTO(
      {required this.reciverID, required this.text, required this.token});
}
