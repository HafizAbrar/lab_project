class CreateSupportReplyDto {
  final String ticketId;
  final String senderId;
  final String message;
  final bool isFromSupport;

  CreateSupportReplyDto({
    required this.ticketId,
    required this.senderId,
    required this.message,
    required this.isFromSupport,
  });

  Map<String, dynamic> toJson() {
    return {
      'ticketId': ticketId,
      'senderId': senderId,
      'message': message,
      'isFromSupport': isFromSupport,
    };
  }
}
