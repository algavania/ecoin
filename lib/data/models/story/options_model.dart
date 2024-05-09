import 'package:freezed_annotation/freezed_annotation.dart';


part 'options_model.freezed.dart';

part 'options_model.g.dart';

@freezed
class OptionsModel with _$OptionsModel {
  const factory OptionsModel({
    required String positive,
    required String negative,
  }) = _OptionsModel;

  factory OptionsModel.fromJson(Map<String, Object?> json) =>
      _$OptionsModelFromJson(json);
}