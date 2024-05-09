import 'package:ecoin/data/models/story/ending_model.dart';
import 'package:ecoin/data/models/story/scenario_model.dart';
import 'package:ecoin/data/models/story/story_model.dart';

abstract class StoryRepository {
  Future<List<StoryModel>> getAllStories();
  Future<List<ScenarioModel>> getScenarios(String storyId);
  Future<List<EndingModel>> getEndings(String storyId, String endingType);
}