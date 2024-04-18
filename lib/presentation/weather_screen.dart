import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:level_orm/presentation/weather_viewmodel.dart';
import 'package:provider/provider.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      init();
    });
  }

  Position? position;

  List<String> emojis = [
    '🌧️',
    '🌦️',
    '⛈️',
    '🌨️',
    '🌞',
    '☁️',
  ];

  String getWeatherCode(int weatherCode) {
    return switch (weatherCode) {
      0 || 1 || 2 || 3 => '맑음',
      45 || 48 => '안개',
      51 || 53 || 55 => '이슬비',
      56 || 57 => '진눈깨비',
      61 || 63 || 65 => '비',
      66 || 67 => '우빙',
      71 || 73 || 75 => '눈',
      77 => '우박',
      80 || 81 || 82 => '이슬비',
      85 || 86 => '눈보라',
      95 || 96 || 99 => '천둥번개',
      _ => '🌞',
    };
  }

  List<Map<String, String>> toSevenDaysWeather(WeatherViewModel viewModel) {
    final List<Map<String, String>> week = [];
    if (viewModel.model != null) {
      for (int i = 0; i < viewModel.model!.time.length; i += 24) {
        Map<String, String> result = {
          'time': viewModel.model!.time[i],
          'weatherCode': getWeatherCode(viewModel.model!.weatherCode[i]),
          'temperature_2m': '${viewModel.model!.temperature_2m[i]}',
        };

        week.add(result);
      }
    }
    return week;
  }

  Future<void> init() async {
    // 위치 값 얻기
    position = await _determinePosition();

    // print(position);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<WeatherViewModel>();

    if (position == null) {
      print('gps 신호가 약합니다.');
    } else {
      viewModel.getWeatherInfo(position!.latitude, position!.longitude);
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: const Text(
          'Weather App',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.refresh,
                size: 25,
              )),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 80,
            child: Text(
              DateTime.now().toString().substring(0, 10),
              style: const TextStyle(fontSize: 24),
            ),
          ),
          ...toSevenDaysWeather(viewModel).map((e) {
            return ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: Text(
                    e['time']!,
                  )),
                  Expanded(
                    child: Text(e['temperature_2m']!),
                  ),
                  Expanded(
                    child: Text(e['weatherCode']!),
                  )
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}

Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  // 사용자 동의
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  return await Geolocator.getCurrentPosition();
}
