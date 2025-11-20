import '../../data/models/create_invoice_item_dto.dart';
import '../../data/models/invoice_item_dto.dart';

abstract class InvoiceItemsRepository {
  Future<void> createInvoiceItem(CreateInvoiceItemDto dto);
  Future<List<InvoiceItemDto>> getInvoiceItems();
  Future<void> updateInvoiceItem(String id, CreateInvoiceItemDto dto);
  Future<void> deleteInvoiceItem(String id);
}
