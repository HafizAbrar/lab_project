import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/providers/auth_providers.dart';
import '../../data/models/payment_dto.dart';
import '../../data/repositories/payments_repository_impl.dart';
import '../../data/sources/payment_remote_source.dart';
import '../../domain/repositories/payments_repository.dart';

// Remote Source Provider
final paymentRemoteSourceProvider = Provider<PaymentRemoteSource>(
      (ref) => PaymentRemoteSource(ref.read(dioProvider)),
);

// Repository Provider
final paymentsRepositoryProvider = Provider<PaymentsRepository>(
      (ref) => PaymentsRepositoryImpl(
    PaymentRemoteSource(ref.read(dioProvider)),
  ),
);

// Convenience FutureProviders (optional)
final paymentsListProvider = FutureProvider.autoDispose((ref) async {
  final repo = ref.watch(paymentsRepositoryProvider);
  return repo.getAllPayments();
});

final paymentByIdProvider = FutureProvider.family.autoDispose<PaymentDto, String>((ref, id) async {
  final repo = ref.watch(paymentsRepositoryProvider);
  return repo.getPaymentById(id);
});
