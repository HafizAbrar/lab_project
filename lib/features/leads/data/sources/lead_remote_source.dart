import 'package:dio/dio.dart';
import '../models/lead_dto.dart';
import '../models/create_lead_dto.dart';

class LeadRemoteSource {
  final Dio dio;

  LeadRemoteSource(this.dio);

  Future<List<LeadDto>> getLeads() async {
    final response = await dio.get('/leads');
    return (response.data as List).map((e) => LeadDto.fromJson(e)).toList();
  }

  Future<void> createLead(CreateLeadDto dto) async {
    await dio.post('/leads', data: dto.toJson());
  }

  Future<void> updateLead(String id, CreateLeadDto dto) async {
    await dio.put('/leads/$id', data: dto.toJson());
  }

  Future<void> deleteLead(String id) async {
    await dio.delete('/leads/$id');
  }
}
