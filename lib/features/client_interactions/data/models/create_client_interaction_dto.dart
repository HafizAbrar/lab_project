class CreateClientInteractionDto {
  final String clientId;
  final String employeeId;
  final String type;
  final String summary;
  final DateTime interactionDate;
  final String? nextSteps;
  final DateTime? nextFollowUpDate;

  CreateClientInteractionDto({
    required this.clientId,
    required this.employeeId,
    required this.type,
    required this.summary,
    required this.interactionDate,
    this.nextSteps,
    this.nextFollowUpDate,
  });

  Map<String, dynamic> toJson() => {
    'clientId': clientId,
    'employeeId': employeeId,
    'type': type,
    'summary': summary,
    'interactionDate': interactionDate.toIso8601String(),
    'nextSteps': nextSteps,
    'nextFollowUpDate': nextFollowUpDate?.toIso8601String(),
  };
}
