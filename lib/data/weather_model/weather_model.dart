import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather_model.freezed.dart';

part 'weather_model.g.dart';

@freezed
class WeatherModel with _$WeatherModel {
  const factory WeatherModel({
    required List<String> time,
    required List<num> temperature_2m,
    required List<int> weatherCode,

  }) = _WeatherModel;
  factory WeatherModel.fromJson(Map<String, Object?> json) => _$WeatherModelFromJson(json);
}