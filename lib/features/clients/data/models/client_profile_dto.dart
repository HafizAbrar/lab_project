// clients_dto.dart

class ClientProfileDto {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String company;
  final String address;
  final String website;
  final String profilePhoto;

  ClientProfileDto({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.company,
    required this.address,
    required this.website,
    required this.profilePhoto,
  });

  factory ClientProfileDto.fromJson(Map<String, dynamic> json) {
    return ClientProfileDto(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      company: json['company'] ?? '',
      address: json['address'] ?? '',
      website: json['website'] ?? '',
      profilePhoto: json['profilePhoto'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'company': company,
      'address': address,
      'website': website,
      'profilePhoto': profilePhoto,
    };
  }
}
