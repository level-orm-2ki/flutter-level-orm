import 'package:level_orm/data/api/weather_api.dart';
import 'package:level_orm/data/mapper/weather_mapper.dart';
import 'package:level_orm/data/repository/weather_repository.dart';
import 'package:level_orm/data/weather_model/weather_model.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherApi _weatherApi;

  WeatherRepositoryImpl({required WeatherApi weatherApi})
      : _weatherApi = weatherApi;

  @override
  Future<WeatherModel> getWeatherInfoData(double latitude, double longitude) async {
    final dto = await _weatherApi.getWeatherInfo(latitude, longitude);
    if (dto.hourly == null) {
      throw Exception('hourly가 없습니다');
    }
    return dto.hourly!.toWeather();
  }
}
