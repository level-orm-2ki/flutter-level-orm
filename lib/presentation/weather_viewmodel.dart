import 'package:flutter/cupertino.dart';
import 'package:level_orm/data/api/weather_api.dart';
import 'package:level_orm/data/repository/weather_repository.dart';

import '../data/weather_model/weather_model.dart';

class WeatherViewModel with ChangeNotifier {
  final WeatherRepository _repository;
  WeatherModel? model;

  WeatherViewModel({
    required WeatherRepository repository,
  }) : _repository = repository;

  Future<void> getWeatherInfo(double latitude, double longitude) async {
    model = await _repository.getWeatherInfoData(latitude, longitude);
    notifyListeners();
  }
}
