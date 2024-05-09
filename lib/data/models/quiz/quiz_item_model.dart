import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecoin/data/models/timestamp_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'quiz_item_model.freezed.dart';

part 'quiz_item_model.g.dart';

@freezed
class QuizItemModel with _$QuizItemModel {
  const factory QuizItemModel({
    required String question,
    required String answer,
    required Map<String, String> choices,
    @TimestampConverter() required DateTime createdAt,
    int? id,
  }) = _QuizItemModel;

  factory QuizItemModel.fromJson(Map<String, Object?> json) =>
      _$QuizItemModelFromJson(json);
}
