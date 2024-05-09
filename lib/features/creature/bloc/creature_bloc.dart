import 'package:bloc/bloc.dart';
import 'package:ecoin/data/models/creature/creature_model.dart';
import 'package:ecoin/features/creature/data/repository/creature_repository.dart';
import 'package:ecoin/utils/logger.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'creature_event.dart';
part 'creature_state.dart';
part 'creature_bloc.freezed.dart';

class CreatureBloc extends Bloc<CreatureEvent, CreatureState> {
  CreatureBloc({
    required CreatureRepository repository,
  }) : super(
    const CreatureState.loading(),
  ) {
    _repository = repository;

    on<_GetAllCreatures>(
      _onGetAllCreaturesEvent,
    );
    on<_GetCreaturesByType>(
      _onGetCreaturesByTypeEvent,
    );
  }

  late final CreatureRepository _repository;

  Future<void> _onGetAllCreaturesEvent(
      _GetAllCreatures event,
      Emitter<CreatureState> emit,
      ) async {
    emit(const CreatureState.loading());
    try {
      final list = await _repository.getAllCreatures();
      emit(CreatureState.loaded(list));
    } catch (e, s) {
      logger.e(e.toString(), stackTrace: s);
      emit(CreatureState.error(e.toString()));
    }
  }

  Future<void> _onGetCreaturesByTypeEvent(
      _GetCreaturesByType event,
      Emitter<CreatureState> emit,
      ) async {
    emit(const CreatureState.loading());
    try {
      final list = await _repository.getCreaturesByType(event.type);
      emit(CreatureState.loaded(list));
    } catch (e, s) {
      logger.e(e.toString(), stackTrace: s);
      emit(CreatureState.error(e.toString()));
    }
  }
}