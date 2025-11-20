class CreateTaskDto {
  final String title;
  final String description;
  final String assignedTo;
  final String dueDate;
  final String status;
  final String projectId;

  CreateTaskDto({
    required this.title,
    required this.description,
    required this.assignedTo,
    required this.dueDate,
    required this.status,
    required this.projectId,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'assignedTo': assignedTo,
      'dueDate': dueDate,
      'status': status,
      'projectId': projectId,
    };
  }
}
