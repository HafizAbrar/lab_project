import '../../domain/repositories/contact_inquiries_repository.dart';
import '../models/create_contact_inquiry_dto.dart';
import '../models/contact_inquiry_dto.dart';
import '../sources/contact_inquiry_remote_source.dart';

class ContactInquiriesRepositoryImpl implements ContactInquiriesRepository {
  final ContactInquiryRemoteSource remoteSource;

  ContactInquiriesRepositoryImpl(this.remoteSource);

  @override
  Future<void> createContactInquiry(CreateContactInquiryDto dto) {
    return remoteSource.createContactInquiry(dto);
  }

  @override
  Future<void> markAsResolved(String id) {
    return remoteSource.markAsResolved(id);
  }

  @override
  Future<void> deleteContactInquiry(String id) {
    return remoteSource.deleteContactInquiry(id);
  }

  @override
  Future<List<ContactInquiryDto>> getContactInquiries() {
    return remoteSource.getContactInquiries();
  }

  @override
  Future<ContactInquiryDto> getContactInquiryById(String id) {
    return remoteSource.getContactInquiryById(id);
  }
}
