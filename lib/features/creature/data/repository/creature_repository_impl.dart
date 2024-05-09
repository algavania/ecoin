import 'package:ecoin/data/models/creature/creature_model.dart';
import 'package:ecoin/database/db_helper.dart';
import 'package:ecoin/features/creature/data/repository/creature_repository.dart';

class CreatureRepositoryImpl extends CreatureRepository {
  final _db = DbHelper.db;

  @override
  Future<List<CreatureModel>> getAllCreatures() async {
    final list = <CreatureModel>[];
    final res = await _db
        .collection(DbHelper.creatures)
        .orderBy('createdAt', descending: true)
        .get();
    for (final data in res.docs) {
      var model = CreatureModel.fromJson(data.data());
      model = model.copyWith(id: data.id);
      list.add(model);
    }
    return list;
  }

  @override
  Future<List<CreatureModel>> getCreaturesByType(String type) async {
    final list = <CreatureModel>[];
    final res = await _db
        .collection(DbHelper.creatures)
        .where('creatureType', isEqualTo: type)
        .orderBy('createdAt', descending: true)
        .get();
    for (final data in res.docs) {
      var model = CreatureModel.fromJson(data.data());
      model = model.copyWith(id: data.id);
      list.add(model);
    }
    return list;
  }

}