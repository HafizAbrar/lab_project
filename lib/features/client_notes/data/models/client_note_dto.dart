class ClientNoteDto {
  final String id;
  final String clientId;
  final String authorId;
  final String title;
  final String content;
  final DateTime createdAt;
  final DateTime? updatedAt;

  ClientNoteDto({
    required this.id,
    required this.clientId,
    required this.authorId,
    required this.title,
    required this.content,
    required this.createdAt,
    this.updatedAt,
  });

  factory ClientNoteDto.fromJson(Map<String, dynamic> json) => ClientNoteDto(
    id: json['id'],
    clientId: json['clientId'],
    authorId: json['authorId'],
    title: json['title'],
    content: json['content'],
    createdAt: DateTime.parse(json['createdAt']),
    updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'clientId': clientId,
    'authorId': authorId,
    'title': title,
    'content': content,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
  };
}
