import 'package:dio/dio.dart';
import '../models/create_skill_dto.dart';
import '../models/skills_dto.dart';
import '../models/update_skill_dto.dart';

class SkillsRemoteSource {
  final Dio _dio;

  SkillsRemoteSource(this._dio);

  Future<List<SkillDto>> getSkills() async {
    final response = await _dio.get('/skills');

    // If API response is { "data": [ {...}, {...} ] }
    final data = response.data;

    final List<dynamic> skillsJson = data is Map<String, dynamic>
        ? (data['data'] as List? ?? [])
        : (data as List);

    return skillsJson.map((json) => SkillDto.fromJson(json)).toList();
  }

  Future<SkillDto> createSkill(CreateSkillDto dto) async {
    final response = await _dio.post('/skills', data: dto.toJson());
    final data = response.data;

    // If API wraps response inside { "data": {...} }
    return data is Map<String, dynamic> && data.containsKey('data')
        ? SkillDto.fromJson(data['data'])
        : SkillDto.fromJson(data);
  }

  Future<SkillDto> updateSkill(String skillId, UpdateSkillDto dto) async {
    final response = await _dio.patch('/skills/$skillId', data: dto.toJson());
    final data = response.data;

    return data is Map<String, dynamic> && data.containsKey('data')
        ? SkillDto.fromJson(data['data'])
        : SkillDto.fromJson(data);
  }

  Future<void> deleteSkill(String skillId) async {
    await _dio.delete('/skills/$skillId');
  }
}
