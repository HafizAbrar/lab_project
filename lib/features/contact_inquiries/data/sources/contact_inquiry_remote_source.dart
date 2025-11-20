import 'package:dio/dio.dart';
import '../models/contact_inquiry_dto.dart';
import '../models/create_contact_inquiry_dto.dart';

class ContactInquiryRemoteSource {
  final Dio dio;

  ContactInquiryRemoteSource(this.dio);

  Future<void> createContactInquiry(CreateContactInquiryDto dto) async {
    await dio.post('/contact-inquiries', data: dto.toJson());
  }

  Future<void> markAsResolved(String id) async {
    await dio.patch('/contact-inquiries/$id', data: {'isResolved': true});
  }

  Future<void> deleteContactInquiry(String id) async {
    await dio.delete('/contact-inquiries/$id');
  }

  Future<List<ContactInquiryDto>> getContactInquiries() async {
    final response = await dio.get('/contact-inquiries');
    return (response.data as List)
        .map((json) => ContactInquiryDto.fromJson(json))
        .toList();
  }

  Future<ContactInquiryDto> getContactInquiryById(String id) async {
    final response = await dio.get('/contact-inquiries/$id');
    return ContactInquiryDto.fromJson(response.data);
  }
}
