import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecoin/data/models/timestamp_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'quiz_model.freezed.dart';

part 'quiz_model.g.dart';

@freezed
class QuizModel with _$QuizModel {
  const factory QuizModel({
    required String title,
    required String description,
    required String imageUrl,
    @TimestampConverter() required DateTime createdAt,
    int? id,
  }) = _QuizModel;

  factory QuizModel.fromJson(Map<String, Object?> json) =>
      _$QuizModelFromJson(json);
}

QuizModel generateMockQuizModel() {
  return QuizModel(title: 'Ekologi',
      description: 'Uji pemahamanmu mengenai lingkungan dalam kuis ekologi.',
      imageUrl: 'https://firebasestorage.googleapis.com/v0/b/ecoin-extend.appspot.com/o/ecology-98%20(1)%202.png?alt=media&token=276c7813-b5b0-4f4a-9301-39912ba9ce3b',
      createdAt: DateTime.now());
}
