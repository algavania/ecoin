import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:ecoin/data/models/timestamp_converter.dart';

part 'story_model.freezed.dart';

part 'story_model.g.dart';

@freezed
class StoryModel with _$StoryModel {
  const factory StoryModel({
    required String title,
    required String subtitle,
    required String description,
    required String imageUrl,
    @TimestampConverter() required DateTime createdAt,
    String? id,
  }) = _StoryModel;

  factory StoryModel.fromJson(Map<String, Object?> json) =>
      _$StoryModelFromJson(json);
}

StoryModel generateMockStoryModel() {
  return StoryModel(
      title: 'Perubahan Iklim',
      subtitle: 'Pelajari dampak dari aksi-aksimu terhadap iklim planet bumi',
      description: 'Cerita ini mencakup pengetahuan tentang penyebab, dampak, dan solusi terkait perubahan iklim. Ini melibatkan informasi tentang konsep-konsep ilmiah, seperti efek rumah kaca dan pemanasan global. Yuk, pelajari untuk menjaga keberlanjutan lingkungan!',
      imageUrl: 'https://firebasestorage.googleapis.com/v0/b/ecoin-extend.appspot.com/o/global-warming-4.png?alt=media&token=2a76f27f-cd8b-4634-aab3-afe114f2bba2',
      createdAt: DateTime.now());
}