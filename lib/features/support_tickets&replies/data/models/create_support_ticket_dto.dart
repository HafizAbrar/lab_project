class CreateSupportTicketDto {
  final String clientId;
  final String subject;
  final String description;
  final String priority;

  CreateSupportTicketDto({
    required this.clientId,
    required this.subject,
    required this.description,
    required this.priority,
  });

  Map<String, dynamic> toJson() {
    return {
      'clientId': clientId,
      'subject': subject,
      'description': description,
      'priority': priority,
    };
  }
}
