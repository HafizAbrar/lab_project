class ProjectTechnologyDto {
  final String id;
  final String projectId;
  final String technologyId;
  final String addedBy;
  final String addedDate;

  ProjectTechnologyDto({
    required this.id,
    required this.projectId,
    required this.technologyId,
    required this.addedBy,
    required this.addedDate,
  });

  factory ProjectTechnologyDto.fromJson(Map<String, dynamic> json) {
    return ProjectTechnologyDto(
      id: json['id'],
      projectId: json['projectId'],
      technologyId: json['technologyId'],
      addedBy: json['addedBy'],
      addedDate: json['addedDate'],
    );
  }
}
