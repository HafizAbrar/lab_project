import '../../domain/repositories/payments_repository.dart';
import '../models/create_payment_dto.dart';
import '../models/payment_dto.dart';
import '../sources/payment_remote_source.dart';

class PaymentsRepositoryImpl implements PaymentsRepository {
  final PaymentRemoteSource remoteSource;

  PaymentsRepositoryImpl(this.remoteSource);

  @override
  Future<List<PaymentDto>> getAllPayments() {
    return remoteSource.getAllPayments();
  }

  @override
  Future<PaymentDto> getPaymentById(String id) {
    return remoteSource.getPaymentById(id);
  }

  @override
  Future<void> createPayment(CreatePaymentDto dto) {
    return remoteSource.createPayment(dto);
  }

  @override
  Future<void> updatePayment(String id, CreatePaymentDto dto) {
    return remoteSource.updatePayment(id, dto);
  }

  @override
  Future<void> deletePayment(String id) {
    return remoteSource.deletePayment(id);
  }

  @override
  Future<void> refundPayment(String id, {String? reason}) {
    return remoteSource.refundPayment(id, reason: reason);
  }
}
