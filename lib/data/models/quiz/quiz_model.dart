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
    String? id,
  }) = _QuizModel;

  factory QuizModel.fromJson(Map<String, Object?> json) =>
      _$QuizModelFromJson(json);
}

QuizModel generateMockQuizModel() {
  return QuizModel(title: 'Ekologi',
      description: 'Uji pemahamanmu mengenai lingkungan dalam kuis ekologi.',
      imageUrl: 'https://firebasestorage.googleapis.com/v0/b/ecoin-extend.appspot.com/o/thumbnail%20quiz.png?alt=media&token=6d12d23b-caf2-4b92-9d46-f5158c4b2693',
      createdAt: DateTime.now());
}

QuizModel generateMockQuizPageModel() {
  return QuizModel(title: 'Kuis Ekologi',
      description: 'Yuk, uji pemahamanmu mengenai lingkungan dalam kuis pilihan ganda ini!',
      imageUrl: 'https://firebasestorage.googleapis.com/v0/b/ecoin-extend.appspot.com/o/quiz.png?alt=media&token=539b19a1-612d-4978-b33d-876c67ccb540',
      createdAt: DateTime.now());
}