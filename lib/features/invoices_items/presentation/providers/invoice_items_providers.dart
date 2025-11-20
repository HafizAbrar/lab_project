import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/providers/auth_providers.dart';
import '../../data/repositories/invoice_items_repository_impl.dart';
import '../../data/sources/invoice_item_remote_source.dart';
import '../../domain/repositories/invoice_items_repository.dart';

// Remote Source Provider
final invoiceItemRemoteSourceProvider = Provider<InvoiceItemRemoteSource>(
      (ref) => InvoiceItemRemoteSource(ref.read(dioProvider)),
);

// Repository Provider
final invoiceItemsRepositoryProvider = Provider<InvoiceItemsRepository>(
      (ref) => InvoiceItemsRepositoryImpl(
    InvoiceItemRemoteSource(ref.read(dioProvider)),
  ),
);
