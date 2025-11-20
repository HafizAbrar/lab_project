class CreateLeadDto {
  final String name;
  final String email;
  final String? phone;
  final String source;
  final String status;
  final String? company;
  final String? notes;

  CreateLeadDto({
    required this.name,
    required this.email,
    this.phone,
    required this.source,
    required this.status,
    this.company,
    this.notes,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'phone': phone,
    'source': source,
    'status': status,
    'company': company,
    'notes': notes,
  };
}
