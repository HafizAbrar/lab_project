import '../../data/models/client_approval_dto.dart';

abstract class ClientApprovalsRepository {
  Future<List<ClientApprovalDto>> getClientApprovals();
  Future<void> createClientApproval(ClientApprovalDto dto);
  Future<void> updateClientApproval(String id, ClientApprovalDto dto);
  Future<void> deleteClientApproval(String id);
}
