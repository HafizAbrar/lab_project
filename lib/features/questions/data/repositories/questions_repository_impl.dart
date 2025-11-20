import '../../domain/repositories/questions_repository.dart';
import '../models/create_question_dto.dart';
import '../models/question_dto.dart';
import '../sources/question_remote_source.dart';

class QuestionsRepositoryImpl implements QuestionsRepository {
  final QuestionRemoteSource remoteSource;

  QuestionsRepositoryImpl(this.remoteSource);

  @override
  Future<void> createQuestion(CreateQuestionDto dto) =>
      remoteSource.createQuestion(dto);

  @override
  Future<List<QuestionDto>> getAllQuestions() =>
      remoteSource.getAllQuestions();

  @override
  Future<QuestionDto> getQuestionById(String id) =>
      remoteSource.getQuestionById(id);

  @override
  Future<void> updateQuestion(String id, CreateQuestionDto dto) =>
      remoteSource.updateQuestion(id, dto);

  @override
  Future<void> deleteQuestion(String id) =>
      remoteSource.deleteQuestion(id);

  @override
  Future<void> incrementViewCount(String id) =>
      remoteSource.incrementViewCount(id);
}
