class CreateTestimonialDto {
  final String authorName;
  final String authorDesignation;
  final String content;
  final String? imageUrl;

  CreateTestimonialDto({
    required this.authorName,
    required this.authorDesignation,
    required this.content,
    this.imageUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'authorName': authorName,
      'authorDesignation': authorDesignation,
      'content': content,
      if (imageUrl != null) 'imageUrl': imageUrl,
    };
  }
}
