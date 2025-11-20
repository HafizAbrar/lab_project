import '../../data/models/create_case_study_dto.dart';
import '../../data/models/case_study_dto.dart';

abstract class CaseStudiesRepository {
  Future<void> createCaseStudy(CreateCaseStudyDto dto);
  Future<List<CaseStudyDto>> getAllCaseStudies();
  Future<CaseStudyDto> getCaseStudyById(String id);
  Future<void> updateCaseStudy(String id, CreateCaseStudyDto dto);
  Future<void> deleteCaseStudy(String id);
}
