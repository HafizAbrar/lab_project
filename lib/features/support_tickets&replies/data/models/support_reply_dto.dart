class SupportReplyDto {
  final String id;
  final String ticketId;
  final String senderId;
  final String message;
  final bool isFromSupport;
  final DateTime createdAt;

  SupportReplyDto({
    required this.id,
    required this.ticketId,
    required this.senderId,
    required this.message,
    required this.isFromSupport,
    required this.createdAt,
  });

  factory SupportReplyDto.fromJson(Map<String, dynamic> json) {
    return SupportReplyDto(
      id: json['id'] ?? json['_id'] ?? '',
      ticketId: json['ticketId'] ?? '',
      senderId: json['senderId'] ?? '',
      message: json['message'] ?? '',
      isFromSupport: json['isFromSupport'] ?? false,
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ticketId': ticketId,
      'senderId': senderId,
      'message': message,
      'isFromSupport': isFromSupport,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
