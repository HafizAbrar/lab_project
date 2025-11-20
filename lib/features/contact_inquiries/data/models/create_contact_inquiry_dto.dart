class CreateContactInquiryDto {
  final String name;
  final String email;
  final String? phone;
  final String subject;
  final String message;

  CreateContactInquiryDto({
    required this.name,
    required this.email,
    this.phone,
    required this.subject,
    required this.message,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      if (phone != null) 'phone': phone,
      'subject': subject,
      'message': message,
    };
  }
}
