import 'package:level_orm/data/weather_model/weather_model.dart';

import '../dto/weather_dto.dart';

extension ToWeather on HourlyDto {
  WeatherModel toWeather() {
    return WeatherModel(
      time: time ?? [],
      temperature_2m: temperature2m ?? [],
      weatherCode: weathercode?.map((e) => e.toInt()).toList() ?? [],
    );
  }
}
