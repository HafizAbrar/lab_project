import 'package:dio/dio.dart';
import '../models/testimonial_dto.dart';
import '../models/create_testimonial_dto.dart';

class TestimonialRemoteSource {
  final Dio dio;

  TestimonialRemoteSource(this.dio);

  Future<void> createTestimonial(CreateTestimonialDto dto) async {
    await dio.post('/testimonials', data: dto.toJson());
  }

  Future<void> updateTestimonial(String id, CreateTestimonialDto dto) async {
    await dio.put('/testimonials/$id', data: dto.toJson());
  }

  Future<void> deleteTestimonial(String id) async {
    await dio.delete('/testimonials/$id');
  }

  Future<List<TestimonialDto>> getTestimonials() async {
    final response = await dio.get('/testimonials');
    return (response.data as List)
        .map((json) => TestimonialDto.fromJson(json))
        .toList();
  }

  Future<TestimonialDto> getTestimonialById(String id) async {
    final response = await dio.get('/testimonials/$id');
    return TestimonialDto.fromJson(response.data);
  }
}
