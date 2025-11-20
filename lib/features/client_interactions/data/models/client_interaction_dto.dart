class ClientInteractionDto {
  final String id;
  final String clientId;
  final String employeeId; // who interacted with the client
  final String type; // e.g. "Call", "Meeting", "Email", "Follow-up"
  final String summary;
  final DateTime interactionDate;
  final String? nextSteps;
  final DateTime? nextFollowUpDate;
  final DateTime createdAt;

  ClientInteractionDto({
    required this.id,
    required this.clientId,
    required this.employeeId,
    required this.type,
    required this.summary,
    required this.interactionDate,
    this.nextSteps,
    this.nextFollowUpDate,
    required this.createdAt,
  });

  factory ClientInteractionDto.fromJson(Map<String, dynamic> json) =>
      ClientInteractionDto(
        id: json['id'],
        clientId: json['clientId'],
        employeeId: json['employeeId'],
        type: json['type'],
        summary: json['summary'],
        interactionDate: DateTime.parse(json['interactionDate']),
        nextSteps: json['nextSteps'],
        nextFollowUpDate: json['nextFollowUpDate'] != null
            ? DateTime.parse(json['nextFollowUpDate'])
            : null,
        createdAt: DateTime.parse(json['createdAt']),
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'clientId': clientId,
    'employeeId': employeeId,
    'type': type,
    'summary': summary,
    'interactionDate': interactionDate.toIso8601String(),
    'nextSteps': nextSteps,
    'nextFollowUpDate': nextFollowUpDate?.toIso8601String(),
    'createdAt': createdAt.toIso8601String(),
  };
}
