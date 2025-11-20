class CreateCaseStudyDto {
  final String title;
  final String clientName;
  final String industry;
  final String problemStatement;
  final String solution;
  final String results;
  final String imageUrl;
  final bool isFeatured;

  CreateCaseStudyDto({
    required this.title,
    required this.clientName,
    required this.industry,
    required this.problemStatement,
    required this.solution,
    required this.results,
    required this.imageUrl,
    this.isFeatured = false,
  });

  Map<String, dynamic> toJson() => {
    'title': title,
    'clientName': clientName,
    'industry': industry,
    'problemStatement': problemStatement,
    'solution': solution,
    'results': results,
    'imageUrl': imageUrl,
    'isFeatured': isFeatured,
  };
}
