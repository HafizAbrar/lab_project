import 'package:dio/dio.dart';
import '../models/create_client_plan_quotation_dto.dart';
import '../models/client_plan_quotation_dto.dart';

class ClientPlanQuotationRemoteSource {
  final Dio dio;

  ClientPlanQuotationRemoteSource(this.dio);

  Future<void> createClientPlanQuotation(CreateClientPlanQuotationDto dto) async {
    await dio.post('/client-plan-quotations', data: dto.toJson());
  }

  Future<List<ClientPlanQuotationDto>> getAllClientPlanQuotations() async {
    final response = await dio.get('/client-plan-quotations');
    return (response.data as List)
        .map((json) => ClientPlanQuotationDto.fromJson(json))
        .toList();
  }

  Future<void> updateClientPlanQuotation(String id, CreateClientPlanQuotationDto dto) async {
    await dio.put('/client-plan-quotations/$id', data: dto.toJson());
  }

  Future<void> deleteClientPlanQuotation(String id) async {
    await dio.delete('/client-plan-quotations/$id');
  }
}
