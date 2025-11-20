class TaskDto {
  final String id;
  final String title;
  final String description;
  final String assignedTo;
  final String dueDate;
  final String status;
  final String projectId;

  TaskDto({
    required this.id,
    required this.title,
    required this.description,
    required this.assignedTo,
    required this.dueDate,
    required this.status,
    required this.projectId,
  });

  factory TaskDto.fromJson(Map<String, dynamic> json) {
    return TaskDto(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      assignedTo: json['assignedTo'],
      dueDate: json['dueDate'],
      status: json['status'],
      projectId: json['projectId'],
    );
  }
}
