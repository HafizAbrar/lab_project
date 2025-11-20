class CreateClientNoteDto {
  final String clientId;
  final String authorId;
  final String title;
  final String content;

  CreateClientNoteDto({
    required this.clientId,
    required this.authorId,
    required this.title,
    required this.content,
  });

  Map<String, dynamic> toJson() => {
    'clientId': clientId,
    'authorId': authorId,
    'title': title,
    'content': content,
  };
}
