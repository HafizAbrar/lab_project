import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/providers/auth_providers.dart';
import '../../data/repositories/invoices_repository_impl.dart';
import '../../data/sources/invoice_remote_source.dart';
import '../../domain/repositories/invoices_repository.dart';

// Remote Source Provider
final invoiceRemoteSourceProvider = Provider<InvoiceRemoteSource>(
      (ref) => InvoiceRemoteSource(ref.read(dioProvider)),
);

// Repository Provider
final invoicesRepositoryProvider = Provider<InvoicesRepository>(
      (ref) => InvoicesRepositoryImpl(
    InvoiceRemoteSource(ref.read(dioProvider)),
  ),
);
