import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '../../data/models/testimonial_dto.dart';
import '../../data/models/create_testimonial_dto.dart';
import '../../data/sources/testimonial_remote_source.dart';
import '../../data/repositories/testimonials_repository_impl.dart';
import '../../domain/repositories/testimonials_repository.dart';

// Dio provider
final dioProvider = Provider<Dio>(
      (ref) => Dio(BaseOptions(baseUrl: 'https://api.example.com')),
);

// Remote source provider
final testimonialRemoteSourceProvider = Provider<TestimonialRemoteSource>(
      (ref) => TestimonialRemoteSource(ref.watch(dioProvider)),
);

// Repository provider
final testimonialsRepositoryProvider = Provider<TestimonialsRepository>(
      (ref) => TestimonialsRepositoryImpl(ref.watch(testimonialRemoteSourceProvider)),
);

// Fetch all testimonials
final testimonialsProvider = FutureProvider<List<TestimonialDto>>((ref) async {
  final repo = ref.watch(testimonialsRepositoryProvider);
  return repo.getTestimonials();
});

// Create testimonial
final createTestimonialProvider =
FutureProvider.family<void, CreateTestimonialDto>((ref, dto) async {
  final repo = ref.watch(testimonialsRepositoryProvider);
  await repo.createTestimonial(dto);
});
