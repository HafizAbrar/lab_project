class TestimonialDto {
  final String id;
  final String authorName;
  final String authorDesignation;
  final String content;
  final String? imageUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  TestimonialDto({
    required this.id,
    required this.authorName,
    required this.authorDesignation,
    required this.content,
    this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TestimonialDto.fromJson(Map<String, dynamic> json) {
    return TestimonialDto(
      id: json['id'],
      authorName: json['authorName'],
      authorDesignation: json['authorDesignation'],
      content: json['content'],
      imageUrl: json['imageUrl'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'authorName': authorName,
      'authorDesignation': authorDesignation,
      'content': content,
      'imageUrl': imageUrl,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
