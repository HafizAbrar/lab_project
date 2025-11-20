import '../../domain/repositories/client_approvals_repository.dart';
import '../models/client_approval_dto.dart';
import '../sources/client_approval_remote_source.dart';

class ClientApprovalsRepositoryImpl implements ClientApprovalsRepository {
  final ClientApprovalRemoteSource remoteSource;

  ClientApprovalsRepositoryImpl(this.remoteSource);

  @override
  Future<List<ClientApprovalDto>> getClientApprovals() {
    return remoteSource.getClientApprovals();
  }

  @override
  Future<void> createClientApproval(ClientApprovalDto dto) {
    return remoteSource.createClientApproval(dto);
  }

  @override
  Future<void> updateClientApproval(String id, ClientApprovalDto dto) {
    return remoteSource.updateClientApproval(id, dto);
  }

  @override
  Future<void> deleteClientApproval(String id) {
    return remoteSource.deleteClientApproval(id);
  }
}
