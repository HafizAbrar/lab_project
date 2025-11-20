import 'package:dio/dio.dart';
import '../models/client_approval_dto.dart';

class ClientApprovalRemoteSource {
  final Dio dio;

  ClientApprovalRemoteSource(this.dio);

  Future<List<ClientApprovalDto>> getClientApprovals() async {
    final response = await dio.get('/client_approvals');
    return (response.data as List).map((e) => ClientApprovalDto.fromJson(e)).toList();
  }

  Future<void> createClientApproval(ClientApprovalDto dto) async {
    await dio.post('/client_approvals', data: dto.toJson());
  }

  Future<void> updateClientApproval(String id, ClientApprovalDto dto) async {
    await dio.put('/client_approvals/$id', data: dto.toJson());
  }

  Future<void> deleteClientApproval(String id) async {
    await dio.delete('/client_approvals/$id');
  }
}
