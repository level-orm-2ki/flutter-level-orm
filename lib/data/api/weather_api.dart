import 'dart:convert';

import 'package:level_orm/data/common/config/open_meteo_api_config.dart';
import 'package:level_orm/data/dto/weather_dto.dart';
import 'package:http/http.dart' as http;

class WeatherApi {
  final _url = OpenMeteoApiConfig.baseUrl;

  Future<WeatherDto> getWeatherInfo(double latitude, double longitude) async {
    final http.Response response =
        await http.get(Uri.parse(generateUrl(latitude, longitude)));

    if (response.statusCode != 200) {
      throw Exception('weather info error');
    }

    final json = jsonDecode(response.body);

    return WeatherDto.fromJson(json);
  }

  String generateUrl(double latitude, double longitude) {
    return '$_url/v1/forecast?hourly=temperature_2m,weathercode,relativehumidity_2m,'
        'windspeed_10m,pressure_msl&latitude=$latitude&longitude=$longitude';
  }
}
