class ClientApprovalDto {
  final String id;
  final String clientId;
  final String projectId;
  final String approvalType; // e.g. "Design", "Proposal", "Payment"
  final String description;
  final bool isApproved;
  final DateTime requestedAt;
  final DateTime? approvedAt;
  final String? approvedBy;

  ClientApprovalDto({
    required this.id,
    required this.clientId,
    required this.projectId,
    required this.approvalType,
    required this.description,
    required this.isApproved,
    required this.requestedAt,
    this.approvedAt,
    this.approvedBy,
  });

  factory ClientApprovalDto.fromJson(Map<String, dynamic> json) => ClientApprovalDto(
    id: json['id'],
    clientId: json['clientId'],
    projectId: json['projectId'],
    approvalType: json['approvalType'],
    description: json['description'],
    isApproved: json['isApproved'] ?? false,
    requestedAt: DateTime.parse(json['requestedAt']),
    approvedAt: json['approvedAt'] != null ? DateTime.parse(json['approvedAt']) : null,
    approvedBy: json['approvedBy'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'clientId': clientId,
    'projectId': projectId,
    'approvalType': approvalType,
    'description': description,
    'isApproved': isApproved,
    'requestedAt': requestedAt.toIso8601String(),
    'approvedAt': approvedAt?.toIso8601String(),
    'approvedBy': approvedBy,
  };
}
