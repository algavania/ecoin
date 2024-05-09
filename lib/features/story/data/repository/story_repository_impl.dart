import 'package:ecoin/data/models/story/ending_model.dart';
import 'package:ecoin/data/models/story/scenario_model.dart';
import 'package:ecoin/data/models/story/story_model.dart';
import 'package:ecoin/database/db_helper.dart';
import 'package:ecoin/features/story/data/repository/story_repository.dart';

class StoryRepositoryImpl extends StoryRepository {
  final _db = DbHelper.db;

  @override
  Future<List<StoryModel>> getAllStories({int? limit}) async {
    final list = <StoryModel>[];
    var query = _db.collection(DbHelper.stories).orderBy('createdAt');
    if (limit != null) {
      query = query.limit(limit);
    }
    final res = await query.get();
    for (final data in res.docs) {
      var model = StoryModel.fromJson(data.data());
      model = model.copyWith(id: data.id);
      list.add(model);
    }
    return list;
  }

  @override
  Future<List<EndingModel>> getEndings(
      String storyId, String endingType) async {
    final list = <EndingModel>[];
    final res = await _db
        .collection(DbHelper.stories)
        .doc(storyId)
        .collection(DbHelper.endings)
        .where('type', isEqualTo: endingType)
        .get();
    for (final data in res.docs) {
      var model = EndingModel.fromJson(data.data());
      model = model.copyWith(id: data.id);
      list.add(model);
    }
    return list;
  }

  @override
  Future<List<ScenarioModel>> getScenarios(String storyId) async {
    final list = <ScenarioModel>[];
    final res = await _db
        .collection(DbHelper.stories)
        .doc(storyId)
        .collection(DbHelper.scenarios)
        .orderBy('order')
        .get();
    for (final data in res.docs) {
      var model = ScenarioModel.fromJson(data.data());
      model = model.copyWith(id: data.id);
      list.add(model);
    }
    return list;
  }
}
