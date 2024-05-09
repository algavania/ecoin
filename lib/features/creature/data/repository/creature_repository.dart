import 'package:ecoin/data/models/creature/creature_model.dart';

abstract class CreatureRepository {
  Future<List<CreatureModel>> getCreaturesByType(String type);
  Future<List<CreatureModel>> getAllCreatures();
}
