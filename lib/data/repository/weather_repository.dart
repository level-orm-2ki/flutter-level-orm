import 'package:level_orm/data/weather_model/weather_model.dart';

abstract interface class WeatherRepository {
  Future<WeatherModel> getWeatherInfoData(double latitude, double longitude);

}