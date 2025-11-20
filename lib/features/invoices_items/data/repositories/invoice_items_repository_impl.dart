import '../../domain/repositories/invoice_items_repository.dart';
import '../models/create_invoice_item_dto.dart';
import '../models/invoice_item_dto.dart';
import '../sources/invoice_item_remote_source.dart';

class InvoiceItemsRepositoryImpl implements InvoiceItemsRepository {
  final InvoiceItemRemoteSource remoteSource;

  InvoiceItemsRepositoryImpl(this.remoteSource);

  @override
  Future<void> createInvoiceItem(CreateInvoiceItemDto dto) {
    return remoteSource.createInvoiceItem(dto);
  }

  @override
  Future<List<InvoiceItemDto>> getInvoiceItems() {
    return remoteSource.getInvoiceItems();
  }

  @override
  Future<void> updateInvoiceItem(String id, CreateInvoiceItemDto dto) {
    return remoteSource.updateInvoiceItem(id, dto);
  }

  @override
  Future<void> deleteInvoiceItem(String id) {
    return remoteSource.deleteInvoiceItem(id);
  }
}
