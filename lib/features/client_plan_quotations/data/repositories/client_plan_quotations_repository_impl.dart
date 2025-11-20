import '../../domain/repositories/client_plan_quotations_repository.dart';
import '../models/create_client_plan_quotation_dto.dart';
import '../models/client_plan_quotation_dto.dart';
import '../sources/client_plan_quotation_remote_source.dart';

class ClientPlanQuotationsRepositoryImpl implements ClientPlanQuotationsRepository {
  final ClientPlanQuotationRemoteSource remoteSource;

  ClientPlanQuotationsRepositoryImpl(this.remoteSource);

  @override
  Future<void> createClientPlanQuotation(CreateClientPlanQuotationDto dto) {
    return remoteSource.createClientPlanQuotation(dto);
  }

  @override
  Future<List<ClientPlanQuotationDto>> getAllClientPlanQuotations() {
    return remoteSource.getAllClientPlanQuotations();
  }

  @override
  Future<void> updateClientPlanQuotation(String id, CreateClientPlanQuotationDto dto) {
    return remoteSource.updateClientPlanQuotation(id, dto);
  }

  @override
  Future<void> deleteClientPlanQuotation(String id) {
    return remoteSource.deleteClientPlanQuotation(id);
  }
}
