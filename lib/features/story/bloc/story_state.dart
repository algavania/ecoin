part of 'story_bloc.dart';

@freezed
class StoryState with _$StoryState {
  const factory StoryState.initial() = _Initial;
  const factory StoryState.loading() = _Loading;
  const factory StoryState.overlayLoading() = _OverlayLoading;
  const factory StoryState.error(String error) = _Error;
  const factory StoryState.loaded(List<StoryModel> list) = _Loaded;
  const factory StoryState.scenariosLoaded(List<ScenarioModel> list) = _ScenarioLoaded;
  const factory StoryState.endingsLoaded(List<EndingModel> list) = _EndingLoaded;
}
