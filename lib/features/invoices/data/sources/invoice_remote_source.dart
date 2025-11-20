import 'package:dio/dio.dart';
import '../models/create_invoice_dto.dart';
import '../models/invoice_dto.dart';

class InvoiceRemoteSource {
  final Dio dio;

  InvoiceRemoteSource(this.dio);

  Future<void> createInvoice(CreateInvoiceDto dto) async {
    await dio.post('/invoices', data: dto.toJson());
  }

  Future<List<InvoiceDto>> getAllInvoices() async {
    final response = await dio.get('/invoices');
    return (response.data as List)
        .map((json) => InvoiceDto.fromJson(json))
        .toList();
  }

  Future<void> updateInvoice(String id, CreateInvoiceDto dto) async {
    await dio.put('/invoices/$id', data: dto.toJson());
  }

  Future<void> deleteInvoice(String id) async {
    await dio.delete('/invoices/$id');
  }
}
