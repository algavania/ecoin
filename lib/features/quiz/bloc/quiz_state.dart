part of 'quiz_bloc.dart';

@freezed
class QuizState with _$QuizState {
  const factory QuizState.initial() = _Initial;
  const factory QuizState.loading() = _Loading;
  const factory QuizState.error(String error) = _Error;
  const factory QuizState.quizItemsLoaded(List<QuizItemModel> list) = _QuizItemsLoaded;
}
