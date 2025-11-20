import '../../data/models/contact_inquiry_dto.dart';
import '../../data/models/create_contact_inquiry_dto.dart';

abstract class ContactInquiriesRepository {
  Future<void> createContactInquiry(CreateContactInquiryDto dto);
  Future<void> markAsResolved(String id);
  Future<void> deleteContactInquiry(String id);
  Future<List<ContactInquiryDto>> getContactInquiries();
  Future<ContactInquiryDto> getContactInquiryById(String id);
}
