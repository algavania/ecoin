import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:ecoin/data/models/timestamp_converter.dart';

part 'ending_model.freezed.dart';

part 'ending_model.g.dart';

@freezed
class EndingModel with _$EndingModel {
  const factory EndingModel({
    required String title,
    required String type,
    required String description,
    required String imageUrl,
    @TimestampConverter() required DateTime createdAt,
    String? id,
  }) = _EndingModel;

  factory EndingModel.fromJson(Map<String, Object?> json) =>
      _$EndingModelFromJson(json);
}
