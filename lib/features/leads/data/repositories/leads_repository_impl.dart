import '../../domain/repositories/leads_repository.dart';
import '../models/lead_dto.dart';
import '../models/create_lead_dto.dart';
import '../sources/lead_remote_source.dart';

class LeadsRepositoryImpl implements LeadsRepository {
  final LeadRemoteSource remoteSource;

  LeadsRepositoryImpl(this.remoteSource);

  @override
  Future<List<LeadDto>> getLeads() {
    return remoteSource.getLeads();
  }

  @override
  Future<void> createLead(CreateLeadDto dto) {
    return remoteSource.createLead(dto);
  }

  @override
  Future<void> updateLead(String id, CreateLeadDto dto) {
    return remoteSource.updateLead(id, dto);
  }

  @override
  Future<void> deleteLead(String id) {
    return remoteSource.deleteLead(id);
  }
}
