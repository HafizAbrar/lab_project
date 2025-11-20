import '../../data/models/create_question_dto.dart';
import '../../data/models/question_dto.dart';

abstract class QuestionsRepository {
  Future<void> createQuestion(CreateQuestionDto dto);
  Future<List<QuestionDto>> getAllQuestions();
  Future<QuestionDto> getQuestionById(String id);
  Future<void> updateQuestion(String id, CreateQuestionDto dto);
  Future<void> deleteQuestion(String id);
  Future<void> incrementViewCount(String id);
}
