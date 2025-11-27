// lib/features/projects/data/models/create_project_dto.dart
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
  final String? clientId;
  final List<File>? images; // <-- Accept List<File>

  CreateProjectDto({
    required this.name,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.budget,
    this.clientId,
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
      "clientId": clientId,
    };
  }

  /// Build FormData exactly like your backend expects:
  /// - "data": JSON string
  /// - "files": array of MultipartFile
  Future<FormData> toFormData() async {
    final String jsonString = jsonEncode(toJson());

    final List<MultipartFile> multipartFiles = [];

    if (images != null && images!.isNotEmpty) {
      for (final file in images!) {
        // If you have a compressor utility, compress; otherwise use file directly
        File fileToUpload;
        try {
          final compressed = await ImageCompressor.compressImage(file);
          fileToUpload = compressed;
        } catch (_) {
          // if compressor fails for any reason, fallback to original file
          fileToUpload = file;
        }

        final multipart = await MultipartFile.fromFile(
          fileToUpload.path,
          filename: path.basename(fileToUpload.path),
        );

        multipartFiles.add(multipart);
      }
    }

    final Map<String, dynamic> map = {
      'data': jsonString,
      // If there are files, include them. If not, include empty list to be explicit.
      'files': multipartFiles,
    };

    return FormData.fromMap(map);
  }
}
