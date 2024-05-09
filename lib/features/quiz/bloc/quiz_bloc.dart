import 'package:bloc/bloc.dart';
import 'package:ecoin/data/models/quiz/quiz_item_model.dart';
import 'package:ecoin/features/quiz/data/repository/quiz_repository.dart';
import 'package:ecoin/utils/logger.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'quiz_event.dart';

part 'quiz_state.dart';

part 'quiz_bloc.freezed.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  QuizBloc({
    required QuizRepository repository,
  }) : super(
          const QuizState.loading(),
        ) {
    _repository = repository;

    on<_GetAllQuizItems>(
      _onGetQuizItemsEvent,
    );
  }

  late final QuizRepository _repository;

  Future<void> _onGetQuizItemsEvent(
    _GetAllQuizItems event,
    Emitter<QuizState> emit,
  ) async {
    emit(const QuizState.loading());
    try {
      final list = await _repository.getQuizItems(limit: event.limit);
      emit(QuizState.quizItemsLoaded(list));
    } catch (e, s) {
      logger.e(e.toString(), stackTrace: s);
      emit(QuizState.error(e.toString()));
    }
  }
}
