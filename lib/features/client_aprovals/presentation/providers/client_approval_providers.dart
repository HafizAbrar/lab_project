import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../data/sources/client_approval_remote_source.dart';
import '../../data/repositories/client_approvals_repository_impl.dart';
import '../../domain/repositories/client_approvals_repository.dart';

// Remote Source Provider
final clientApprovalRemoteSourceProvider = Provider<ClientApprovalRemoteSource>(
      (ref) => ClientApprovalRemoteSource(ref.read(dioProvider)),
);

// Repository Provider
final clientApprovalsRepositoryProvider = Provider<ClientApprovalsRepository>(
      (ref) => ClientApprovalsRepositoryImpl(ref.read(clientApprovalRemoteSourceProvider)),
);
