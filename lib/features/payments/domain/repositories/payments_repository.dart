import '../../data/models/create_payment_dto.dart';
import '../../data/models/payment_dto.dart';

abstract class PaymentsRepository {
  Future<List<PaymentDto>> getAllPayments();
  Future<PaymentDto> getPaymentById(String id);
  Future<void> createPayment(CreatePaymentDto dto);
  Future<void> updatePayment(String id, CreatePaymentDto dto);
  Future<void> deletePayment(String id);
  Future<void> refundPayment(String id, {String? reason});
}
