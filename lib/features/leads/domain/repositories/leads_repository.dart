import '../../data/models/lead_dto.dart';
import '../../data/models/create_lead_dto.dart';

abstract class LeadsRepository {
  Future<List<LeadDto>> getLeads();
  Future<void> createLead(CreateLeadDto dto);
  Future<void> updateLead(String id, CreateLeadDto dto);
  Future<void> deleteLead(String id);
}
