part of 'creature_bloc.dart';

@freezed
class CreatureState with _$CreatureState {
  const factory CreatureState.initial() = _Initial;
  const factory CreatureState.loading() = _Loading;
  const factory CreatureState.error(String error) = _Error;
  const factory CreatureState.loaded(List<CreatureModel> list) = _Loaded;
}
