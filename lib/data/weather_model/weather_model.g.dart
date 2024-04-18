// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WeatherModelImpl _$$WeatherModelImplFromJson(Map<String, dynamic> json) =>
    _$WeatherModelImpl(
      time: (json['time'] as List<dynamic>).map((e) => e as String).toList(),
      temperature_2m: (json['temperature_2m'] as List<dynamic>)
          .map((e) => e as num)
          .toList(),
      weatherCode:
          (json['weatherCode'] as List<dynamic>).map((e) => e as int).toList(),
    );

Map<String, dynamic> _$$WeatherModelImplToJson(_$WeatherModelImpl instance) =>
    <String, dynamic>{
      'time': instance.time,
      'temperature_2m': instance.temperature_2m,
      'weatherCode': instance.weatherCode,
    };
