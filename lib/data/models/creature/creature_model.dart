import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecoin/data/models/timestamp_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'creature_model.freezed.dart';

part 'creature_model.g.dart';

@freezed
class CreatureModel with _$CreatureModel {
  const factory CreatureModel({
    required String name,
    required String category,
    required String description,
    required String imageUrl,
    @TimestampConverter() required DateTime createdAt,
    String? modelUrl,
    int? id,
  }) = _AnimalModel;

  factory CreatureModel.fromJson(Map<String, Object?> json) =>
      _$CreatureModelFromJson(json);
}

CreatureModel generateMockCreatureModel() {
  return CreatureModel(
      name: 'Komodo',
      category: 'Reptilia',
      description:
          'Komodo merupakan spesies terbesar dari familia Varanidae, sekaligus kadal terbesar di dunia, dengan rata-rata panjang 2-3 meter dan beratnya bisa mencapai 100 kg. Komodo merupakan pemangsa puncak di habitatnya karena sejauh ini tidak diketahui adanya hewan karnivora besar lain selain biawak ini di sebaran geografisnya.',
      imageUrl:
          'https://cdn0-production-images-kly.akamaized.net/1dRLkjFyJHDQykSXrJfYq4rex1A=/1200x675/smart/filters:quality(75):strip_icc():format(jpeg)/kly-media-production/medias/1038290/original/085955000_1446189479-komodo-dragon-head-on.jpg',
      createdAt: DateTime.now());
}
