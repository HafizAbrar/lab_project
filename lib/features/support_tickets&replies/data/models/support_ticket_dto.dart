class SupportTicketDto {
  final String id;
  final String clientId;
  final String subject;
  final String description;
  final String status; // open, pending, closed
  final String priority; // low, medium, high
  final DateTime createdAt;
  final DateTime updatedAt;

  SupportTicketDto({
    required this.id,
    required this.clientId,
    required this.subject,
    required this.description,
    required this.status,
    required this.priority,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SupportTicketDto.fromJson(Map<String, dynamic> json) {
    return SupportTicketDto(
      id: json['id'] ?? json['_id'] ?? '',
      clientId: json['clientId'] ?? '',
      subject: json['subject'] ?? '',
      description: json['description'] ?? '',
      status: json['status'] ?? 'open',
      priority: json['priority'] ?? 'medium',
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'clientId': clientId,
      'subject': subject,
      'description': description,
      'status': status,
      'priority': priority,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
