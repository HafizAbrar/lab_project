import '../../domain/repositories/case_studies_repository.dart';
import '../models/create_case_study_dto.dart';
import '../models/case_study_dto.dart';
import '../sources/case_study_remote_source.dart';

class CaseStudiesRepositoryImpl implements CaseStudiesRepository {
  final CaseStudyRemoteSource remoteSource;

  CaseStudiesRepositoryImpl(this.remoteSource);

  @override
  Future<void> createCaseStudy(CreateCaseStudyDto dto) {
    return remoteSource.createCaseStudy(dto);
  }

  @override
  Future<List<CaseStudyDto>> getAllCaseStudies() {
    return remoteSource.getAllCaseStudies();
  }

  @override
  Future<CaseStudyDto> getCaseStudyById(String id) {
    return remoteSource.getCaseStudyById(id);
  }

  @override
  Future<void> updateCaseStudy(String id, CreateCaseStudyDto dto) {
    return remoteSource.updateCaseStudy(id, dto);
  }

  @override
  Future<void> deleteCaseStudy(String id) {
    return remoteSource.deleteCaseStudy(id);
  }
}
