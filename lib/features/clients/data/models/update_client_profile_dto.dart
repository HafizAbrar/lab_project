// lib/features/clients/data/models/update_client_profile_dto.dart
import 'dart:io';
import 'package:dio/dio.dart';

class UpdateClientProfileDto {
  final String? name;
  final String? email;
  final String? phone;
  final String? company; // ✅ optional
  final String? address;
  final String? website; // ✅ optional

  UpdateClientProfileDto({
    this.name,
    this.email,
    this.phone,
    this.company,
    this.address,
    this.website,
  });

  Map<String, dynamic> toJson() {
    return {
      if (name != null) "name": name,
      if (email != null) "email": email,
      if (phone != null) "phone": phone,
      if (company != null && company!.isNotEmpty) "company": company,
      if (address != null) "address": address,
      if (website != null && website!.isNotEmpty) "website": website,
    };
  }

  FormData toFormData({File? file}) {
    final map = Map<String, dynamic>.from(toJson());

    if (file != null) {
      map["profile_photo"] = MultipartFile.fromFileSync(
        file.path,
        filename: file.path.split("/").last,
      );
    }

    return FormData.fromMap(map);
  }
}
