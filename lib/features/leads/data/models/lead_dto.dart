class LeadDto {
  final String id;
  final String name;
  final String email;
  final String? phone;
  final String source; // e.g. "Website", "Referral", "LinkedIn", etc.
  final String status; // e.g. "New", "Contacted", "Qualified", "Converted", "Lost"
  final String? company;
  final String? notes;
  final DateTime createdAt;
  final DateTime? updatedAt;

  LeadDto({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    required this.source,
    required this.status,
    this.company,
    this.notes,
    required this.createdAt,
    this.updatedAt,
  });

  factory LeadDto.fromJson(Map<String, dynamic> json) => LeadDto(
    id: json['id'],
    name: json['name'],
    email: json['email'],
    phone: json['phone'],
    source: json['source'],
    status: json['status'],
    company: json['company'],
    notes: json['notes'],
    createdAt: DateTime.parse(json['createdAt']),
    updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'phone': phone,
    'source': source,
    'status': status,
    'company': company,
    'notes': notes,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
  };
}
