import 'package:dio/dio.dart';
import '../models/create_case_study_dto.dart';
import '../models/case_study_dto.dart';

class CaseStudyRemoteSource {
  final Dio dio;

  CaseStudyRemoteSource(this.dio);

  Future<void> createCaseStudy(CreateCaseStudyDto dto) async {
    await dio.post('/case-studies', data: dto.toJson());
  }

  Future<List<CaseStudyDto>> getAllCaseStudies() async {
    final response = await dio.get('/case-studies');
    return (response.data as List)
        .map((json) => CaseStudyDto.fromJson(json))
        .toList();
  }

  Future<CaseStudyDto> getCaseStudyById(String id) async {
    final response = await dio.get('/case-studies/$id');
    return CaseStudyDto.fromJson(response.data);
  }

  Future<void> updateCaseStudy(String id, CreateCaseStudyDto dto) async {
    await dio.put('/case-studies/$id', data: dto.toJson());
  }

  Future<void> deleteCaseStudy(String id) async {
    await dio.delete('/case-studies/$id');
  }
}
