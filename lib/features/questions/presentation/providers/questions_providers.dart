import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../data/repositories/questions_repository_impl.dart';
import '../../data/sources/question_remote_source.dart';
import '../../domain/repositories/questions_repository.dart';

// Remote Source Provider
final questionRemoteSourceProvider = Provider<QuestionRemoteSource>(
      (ref) => QuestionRemoteSource(ref.read(dioProvider)),
);

// Repository Provider
final questionsRepositoryProvider = Provider<QuestionsRepository>(
      (ref) => QuestionsRepositoryImpl(
    QuestionRemoteSource(ref.read(dioProvider)),
  ),
);
