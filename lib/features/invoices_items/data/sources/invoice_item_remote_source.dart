import 'package:dio/dio.dart';

import '../models/create_invoice_item_dto.dart';
import '../models/invoice_item_dto.dart';

class InvoiceItemRemoteSource {
  final Dio dio;

  InvoiceItemRemoteSource(this.dio);

  Future<void> createInvoiceItem(CreateInvoiceItemDto dto) async {
    await dio.post('/invoice-items', data: dto.toJson());
  }

  Future<List<InvoiceItemDto>> getInvoiceItems() async {
    final response = await dio.get('/invoice-items');
    return (response.data as List)
        .map((e) => InvoiceItemDto.fromJson(e))
        .toList();
  }

  Future<void> updateInvoiceItem(String id, CreateInvoiceItemDto dto) async {
    await dio.put('/invoice-items/$id', data: dto.toJson());
  }

  Future<void> deleteInvoiceItem(String id) async {
    await dio.delete('/invoice-items/$id');
  }
}
