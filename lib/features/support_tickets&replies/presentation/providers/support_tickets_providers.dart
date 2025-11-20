import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/providers/auth_providers.dart';
import '../../data/repositories/support_tickets_repository_impl.dart';
import '../../data/sources/support_ticket_remote_source.dart';
import '../../domain/repositories/support_tickets_repository.dart';

// Remote Source Provider
final supportTicketRemoteSourceProvider = Provider<SupportTicketRemoteSource>(
      (ref) => SupportTicketRemoteSource(ref.read(dioProvider)),
);

// Repository Provider
final supportTicketsRepositoryProvider = Provider<SupportTicketsRepository>(
      (ref) => SupportTicketsRepositoryImpl(
    SupportTicketRemoteSource(ref.read(dioProvider)),
  ),
);
