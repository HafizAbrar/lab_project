// lib/features/technologies/data/repositories/technologies_repository_impl.dart

import '../../domain/repositories/technologies_repository.dart';
import '../sources/technologies_remote_source.dart';
import '../models/create_technology_dto.dart';
import '../models/technology_dto.dart';

class TechnologiesRepositoryImpl implements TechnologiesRepository {
  final TechnologiesRemoteSource remoteSource;

  TechnologiesRepositoryImpl(this.remoteSource);

  @override
  Future<void> createTechnology(CreateTechnologyDto dto) {
    return remoteSource.createTechnology(dto);
  }

  @override
  Future<void> updateTechnology(String technologyId, CreateTechnologyDto dto) {
    return remoteSource.updateTechnology(technologyId, dto);
  }

  @override
  Future<List<TechnologyDto>> getAllTechnologies() {
    return remoteSource.getAllTechnologies();
  }

  @override
  Future<TechnologyDto> getTechnologyById(String technologyId) {
    return remoteSource.getTechnologyById(technologyId);
  }

  @override
  Future<void> deleteTechnology(String technologyId) {
    return remoteSource.deleteTechnology(technologyId);
  }
}
