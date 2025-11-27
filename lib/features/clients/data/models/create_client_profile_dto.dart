// lib/features/clients/data/models/create_client_profile_dto.dart
import 'dart:io';
import 'package:dio/dio.dart';

class CreateClientProfileDto {
  final String user_id;
  final String name;
  final String? email;
  final String? phone;
  final String? company; // ✅ optional
  final String? address;
  final String? website; // ✅ optional

  CreateClientProfileDto({
    required this.user_id,
    required this.name,
    this.email,
    this.phone,
    this.company,
    this.address,
    this.website,
  });

  Map<String, dynamic> toJson() {
    return {
      "user_id": user_id,
      "name": name,
      "email": email,
      "phone": phone,
      if (company != null && company!.isNotEmpty) "company": company,
      "address": address,
      if (website != null && website!.isNotEmpty) "website": website,
    };
  }

  /// Convert to multipart form-data
  Future<FormData> toFormData({File? file}) async {
    final map = Map<String, dynamic>.from(toJson());

    if (file != null) {
      map["profile_photo"] = await MultipartFile.fromFile(
        file.path,
        filename: file.path.split("/").last,
      );
    }

    return FormData.fromMap(map);
  }
}
