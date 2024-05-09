part of 'creature_bloc.dart';

@freezed
class CreatureEvent with _$CreatureEvent {
  const factory CreatureEvent.started() = _Started;
  const factory CreatureEvent.getAllCreatures() = _GetAllCreatures;
  const factory CreatureEvent.getCreaturesByType(String type) = _GetCreaturesByType;
}
