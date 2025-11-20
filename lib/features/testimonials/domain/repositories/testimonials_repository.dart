import '../../data/models/testimonial_dto.dart';
import '../../data/models/create_testimonial_dto.dart';

abstract class TestimonialsRepository {
  Future<void> createTestimonial(CreateTestimonialDto dto);
  Future<void> updateTestimonial(String id, CreateTestimonialDto dto);
  Future<void> deleteTestimonial(String id);
  Future<List<TestimonialDto>> getTestimonials();
  Future<TestimonialDto> getTestimonialById(String id);
}
