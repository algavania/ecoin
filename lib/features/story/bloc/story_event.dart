part of 'story_bloc.dart';

@freezed
class StoryEvent with _$StoryEvent {
  const factory StoryEvent.started() = _Started;
  const factory StoryEvent.getAllStories({int? limit}) = _GetAllStories;
  const factory StoryEvent.getScenarios(String storyId) = _GetScenarios;
  const factory StoryEvent.getEndings(String storyId, String endingType) = _GetEndings;
}
