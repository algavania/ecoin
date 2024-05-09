import 'package:bloc/bloc.dart';
import 'package:ecoin/data/models/story/ending_model.dart';
import 'package:ecoin/data/models/story/scenario_model.dart';
import 'package:ecoin/data/models/story/story_model.dart';
import 'package:ecoin/features/story/data/repository/story_repository.dart';
import 'package:ecoin/utils/logger.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'story_event.dart';
part 'story_state.dart';
part 'story_bloc.freezed.dart';


class StoryBloc extends Bloc<StoryEvent, StoryState> {
  StoryBloc({
    required StoryRepository repository,
  }) : super(
    const StoryState.loading(),
  ) {
    _repository = repository;

    on<_GetAllStories>(
      _onGetStoriesEvent,
    );
    on<_GetEndings>(
      _onGetEndingsEvent,
    );
    on<_GetScenarios>(
      _onGetScenariosEvent,
    );
  }

  late final StoryRepository _repository;

  Future<void> _onGetStoriesEvent(
      _GetAllStories event,
      Emitter<StoryState> emit,
      ) async {
    emit(const StoryState.loading());
    try {
      final list = await _repository.getAllStories(limit: event.limit);
      emit(StoryState.loaded(list));
    } catch (e, s) {
      logger.e(e.toString(), stackTrace: s);
      emit(StoryState.error(e.toString()));
    }
  }

  Future<void> _onGetEndingsEvent(
      _GetEndings event,
      Emitter<StoryState> emit,
      ) async {
    emit(const StoryState.overlayLoading());
    try {
      final list = await _repository.getEndings(event.storyId, event.endingType);
      emit(StoryState.endingsLoaded(list));
    } catch (e, s) {
      logger.e(e.toString(), stackTrace: s);
      emit(StoryState.error(e.toString()));
    }
  }

  Future<void> _onGetScenariosEvent(
      _GetScenarios event,
      Emitter<StoryState> emit,
      ) async {
    emit(const StoryState.overlayLoading());
    try {
      final list = await _repository.getScenarios(event.storyId);
      emit(StoryState.scenariosLoaded(list));
    } catch (e, s) {
      logger.e(e.toString(), stackTrace: s);
      emit(StoryState.error(e.toString()));
    }
  }
}
