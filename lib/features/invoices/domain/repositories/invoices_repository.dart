import '../../data/models/create_invoice_dto.dart';
import '../../data/models/invoice_dto.dart';

abstract class InvoicesRepository {
  Future<void> createInvoice(CreateInvoiceDto dto);
  Future<List<InvoiceDto>> getAllInvoices();
  Future<void> updateInvoice(String id, CreateInvoiceDto dto);
  Future<void> deleteInvoice(String id);
}
