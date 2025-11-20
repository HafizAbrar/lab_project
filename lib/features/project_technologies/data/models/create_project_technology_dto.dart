class CreateProjectTechnologyDto {
  final String projectId;
  final String technologyId;
  final String addedBy;
  final String addedDate;

  CreateProjectTechnologyDto({
    required this.projectId,
    required this.technologyId,
    required this.addedBy,
    required this.addedDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'projectId': projectId,
      'technologyId': technologyId,
      'addedBy': addedBy,
      'addedDate': addedDate,
    };
  }
}
