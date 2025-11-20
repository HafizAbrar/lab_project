import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';

import '../../data/models/contact_inquiry_dto.dart';
import '../../data/models/create_contact_inquiry_dto.dart';
import '../../data/sources/contact_inquiry_remote_source.dart';
import '../../data/repositories/contact_inquiries_repository_impl.dart';
import '../../domain/repositories/contact_inquiries_repository.dart';

// Dio Provider
final dioProvider = Provider<Dio>(
      (ref) => Dio(BaseOptions(baseUrl: 'https://api.example.com')),
);

// Remote Source Provider
final contactInquiryRemoteSourceProvider = Provider<ContactInquiryRemoteSource>(
      (ref) => ContactInquiryRemoteSource(ref.watch(dioProvider)),
);

// Repository Provider
final contactInquiriesRepositoryProvider =
Provider<ContactInquiriesRepository>(
      (ref) => ContactInquiriesRepositoryImpl(
    ref.watch(contactInquiryRemoteSourceProvider),
  ),
);

// Fetch All Contact Inquiries
final contactInquiriesProvider =
FutureProvider<List<ContactInquiryDto>>((ref) async {
  final repo = ref.watch(contactInquiriesRepositoryProvider);
  return repo.getContactInquiries();
});

// Create a New Inquiry
final createContactInquiryProvider =
FutureProvider.family<void, CreateContactInquiryDto>((ref, dto) async {
  final repo = ref.watch(contactInquiriesRepositoryProvider);
  await repo.createContactInquiry(dto);
});

// Mark Inquiry as Resolved
final markInquiryResolvedProvider =
FutureProvider.family<void, String>((ref, id) async {
  final repo = ref.watch(contactInquiriesRepositoryProvider);
  await repo.markAsResolved(id);
});
