import '../../domain/repositories/invoices_repository.dart';
import '../models/create_invoice_dto.dart';
import '../models/invoice_dto.dart';
import '../sources/invoice_remote_source.dart';

class InvoicesRepositoryImpl implements InvoicesRepository {
  final InvoiceRemoteSource remoteSource;

  InvoicesRepositoryImpl(this.remoteSource);

  @override
  Future<void> createInvoice(CreateInvoiceDto dto) {
    return remoteSource.createInvoice(dto);
  }

  @override
  Future<List<InvoiceDto>> getAllInvoices() {
    return remoteSource.getAllInvoices();
  }

  @override
  Future<void> updateInvoice(String id, CreateInvoiceDto dto) {
    return remoteSource.updateInvoice(id, dto);
  }

  @override
  Future<void> deleteInvoice(String id) {
    return remoteSource.deleteInvoice(id);
  }
}
