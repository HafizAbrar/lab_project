// lib/features/technologies/domain/repositories/technologies_repository.dart

import '../../data/models/create_technology_dto.dart';
import '../../data/models/technology_dto.dart';

abstract class TechnologiesRepository {
  Future<void> createTechnology(CreateTechnologyDto dto);
  Future<void> updateTechnology(String technologyId, CreateTechnologyDto dto);
  Future<List<TechnologyDto>> getAllTechnologies();
  Future<TechnologyDto> getTechnologyById(String technologyId);
  Future<void> deleteTechnology(String technologyId);
}
