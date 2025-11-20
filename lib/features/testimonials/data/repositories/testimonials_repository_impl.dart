import '../../domain/repositories/testimonials_repository.dart';
import '../models/create_testimonial_dto.dart';
import '../models/testimonial_dto.dart';
import '../sources/testimonial_remote_source.dart';

class TestimonialsRepositoryImpl implements TestimonialsRepository {
  final TestimonialRemoteSource remoteSource;

  TestimonialsRepositoryImpl(this.remoteSource);

  @override
  Future<void> createTestimonial(CreateTestimonialDto dto) {
    return remoteSource.createTestimonial(dto);
  }

  @override
  Future<void> updateTestimonial(String id, CreateTestimonialDto dto) {
    return remoteSource.updateTestimonial(id, dto);
  }

  @override
  Future<void> deleteTestimonial(String id) {
    return remoteSource.deleteTestimonial(id);
  }

  @override
  Future<List<TestimonialDto>> getTestimonials() {
    return remoteSource.getTestimonials();
  }

  @override
  Future<TestimonialDto> getTestimonialById(String id) {
    return remoteSource.getTestimonialById(id);
  }
}
