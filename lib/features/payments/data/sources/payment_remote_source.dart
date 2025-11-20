import 'package:dio/dio.dart';
import '../models/payment_dto.dart';
import '../models/create_payment_dto.dart';

class PaymentRemoteSource {
  final Dio dio;

  PaymentRemoteSource(this.dio);

  Future<List<PaymentDto>> getAllPayments() async {
    final response = await dio.get('/payments');
    return (response.data as List)
        .map((e) => PaymentDto.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<PaymentDto> getPaymentById(String id) async {
    final response = await dio.get('/payments/$id');
    return PaymentDto.fromJson(response.data as Map<String, dynamic>);
  }

  Future<void> createPayment(CreatePaymentDto dto) async {
    await dio.post('/payments', data: dto.toJson());
  }

  Future<void> updatePayment(String id, CreatePaymentDto dto) async {
    await dio.put('/payments/$id', data: dto.toJson());
  }

  Future<void> deletePayment(String id) async {
    await dio.delete('/payments/$id');
  }

  // Optional: mark as refunded / capture / void (depends on backend)
  Future<void> refundPayment(String id, {String? reason}) async {
    await dio.post('/payments/$id/refund', data: {'reason': reason});
  }
}
