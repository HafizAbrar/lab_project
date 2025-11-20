class ContactInquiryDto {
  final String id;
  final String name;
  final String email;
  final String? phone;
  final String subject;
  final String message;
  final DateTime createdAt;
  final bool isResolved;

  ContactInquiryDto({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    required this.subject,
    required this.message,
    required this.createdAt,
    required this.isResolved,
  });

  factory ContactInquiryDto.fromJson(Map<String, dynamic> json) {
    return ContactInquiryDto(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      subject: json['subject'],
      message: json['message'],
      createdAt: DateTime.parse(json['createdAt']),
      isResolved: json['isResolved'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'subject': subject,
      'message': message,
      'createdAt': createdAt.toIso8601String(),
      'isResolved': isResolved,
    };
  }
}
