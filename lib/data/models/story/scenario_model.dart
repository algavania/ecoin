import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecoin/data/models/story/options_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:ecoin/data/models/timestamp_converter.dart';

part 'scenario_model.freezed.dart';

part 'scenario_model.g.dart';

@freezed
class ScenarioModel with _$ScenarioModel {
  const factory ScenarioModel({
    required String imageUrl,
    required String question,
    required int order,
    required String scene,
    required String title,
    required OptionsModel options,
    @TimestampConverter() required DateTime createdAt,
    String? id,
  }) = _ScenarioModel;

  factory ScenarioModel.fromJson(Map<String, Object?> json) =>
      _$ScenarioModelFromJson(json);
}
