// lib/features/technologies/data/sources/technologies_remote_source.dart

import 'package:dio/dio.dart';
import '../models/create_technology_dto.dart';
import '../models/technology_dto.dart';

class TechnologiesRemoteSource {
  final Dio dio;

  TechnologiesRemoteSource(this.dio);

  // Create Technology
  Future<void> createTechnology(CreateTechnologyDto dto) async {
    await dio.post('/technologies', data: dto.toJson());
  }

  // Update Technology
  Future<void> updateTechnology(String technologyId, CreateTechnologyDto dto) async {
    await dio.put('/technologies/$technologyId', data: dto.toJson());
  }

  // Get all Technologies
  Future<List<TechnologyDto>> getAllTechnologies() async {
    final response = await dio.get('/technologies');
    return (response.data as List)
        .map((e) => TechnologyDto.fromJson(e))
        .toList();
  }

  // Get single Technology by ID
  Future<TechnologyDto> getTechnologyById(String technologyId) async {
    final response = await dio.get('/technologies/$technologyId');
    return TechnologyDto.fromJson(response.data);
  }

  // Delete Technology
  Future<void> deleteTechnology(String technologyId) async {
    await dio.delete('/technologies/$technologyId');
  }
}
