import 'package:dio/dio.dart';
import '../models/create_question_dto.dart';
import '../models/question_dto.dart';

class QuestionRemoteSource {
  final Dio dio;

  QuestionRemoteSource(this.dio);

  Future<void> createQuestion(CreateQuestionDto dto) async {
    await dio.post('/questions', data: dto.toJson());
  }

  Future<List<QuestionDto>> getAllQuestions() async {
    final response = await dio.get('/questions');
    return (response.data as List)
        .map((json) => QuestionDto.fromJson(json))
        .toList();
  }

  Future<QuestionDto> getQuestionById(String id) async {
    final response = await dio.get('/questions/$id');
    return QuestionDto.fromJson(response.data);
  }

  Future<void> updateQuestion(String id, CreateQuestionDto dto) async {
    await dio.put('/questions/$id', data: dto.toJson());
  }

  Future<void> deleteQuestion(String id) async {
    await dio.delete('/questions/$id');
  }

  Future<void> incrementViewCount(String id) async {
    await dio.patch('/questions/$id/view');
  }
}
