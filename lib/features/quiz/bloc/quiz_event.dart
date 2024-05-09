part of 'quiz_bloc.dart';

@freezed
class QuizEvent with _$QuizEvent {
  const factory QuizEvent.started() = _Started;
  const factory QuizEvent.getAllQuizItems({int? limit}) = _GetAllQuizItems;
}
