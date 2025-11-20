import '../../data/models/create_client_plan_quotation_dto.dart';
import '../../data/models/client_plan_quotation_dto.dart';

abstract class ClientPlanQuotationsRepository {
  Future<void> createClientPlanQuotation(CreateClientPlanQuotationDto dto);
  Future<List<ClientPlanQuotationDto>> getAllClientPlanQuotations();
  Future<void> updateClientPlanQuotation(String id, CreateClientPlanQuotationDto dto);
  Future<void> deleteClientPlanQuotation(String id);
}
