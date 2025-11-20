import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../data/repositories/case_studies_repository_impl.dart';
import '../../data/sources/case_study_remote_source.dart';
import '../../domain/repositories/case_studies_repository.dart';

// Remote Source Provider
final caseStudyRemoteSourceProvider = Provider<CaseStudyRemoteSource>(
      (ref) => CaseStudyRemoteSource(ref.read(dioProvider)),
);

// Repository Provider
final caseStudiesRepositoryProvider = Provider<CaseStudiesRepository>(
      (ref) => CaseStudiesRepositoryImpl(
    CaseStudyRemoteSource(ref.read(dioProvider)),
  ),
);
