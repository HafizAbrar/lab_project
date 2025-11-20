// create_project_dto.dart
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path/path.dart' as path;

import '../../../../shared/utilities/image_compressor.dart';

class CreateProjectDto {
  final String name;
  final String description;
  final String startDate;
  final String endDate;
  final String status;
  final double budget;
  final List<File>? images;

  CreateProjectDto({
    required this.name,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.budget,
    this.images,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "description": description,
      "startDate": startDate,
      "endDate": endDate,
      "status": status,
      "budget": budget,
    };
  }

  /// Convert DTO + compressed images → FormData
  Future<FormData> toFormData() async {
    final formData = FormData();

    // Add JSON data
    formData.fields.add(
      MapEntry('data', jsonEncode(toJson())),
    );

    // Process and compress images before upload
    if (images != null && images!.isNotEmpty) {
      for (final img in images!) {
        // 🟡 Compress image using your ImageCompressor
        final compressed = await ImageCompressor.compressImage(img);

        formData.files.add(
          MapEntry(
            "files",
            await MultipartFile.fromFile(
              compressed.path,
              filename: path.basename(compressed.path),
            ),
          ),
        );
      }
    }

    return formData;
  }
}
