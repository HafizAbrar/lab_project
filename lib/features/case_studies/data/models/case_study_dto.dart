class CaseStudyDto {
  final String id;
  final String title;
  final String clientName;
  final String industry;
  final String problemStatement;
  final String solution;
  final String results;
  final String imageUrl;
  final DateTime publishedAt;
  final bool isFeatured;

  CaseStudyDto({
    required this.id,
    required this.title,
    required this.clientName,
    required this.industry,
    required this.problemStatement,
    required this.solution,
    required this.results,
    required this.imageUrl,
    required this.publishedAt,
    required this.isFeatured,
  });

  factory CaseStudyDto.fromJson(Map<String, dynamic> json) {
    return CaseStudyDto(
      id: json['id'],
      title: json['title'],
      clientName: json['clientName'],
      industry: json['industry'],
      problemStatement: json['problemStatement'],
      solution: json['solution'],
      results: json['results'],
      imageUrl: json['imageUrl'],
      publishedAt: DateTime.parse(json['publishedAt']),
      isFeatured: json['isFeatured'] ?? false,
    );
  }
}
