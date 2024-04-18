import 'package:flutter/material.dart';
import 'package:level_orm/data/api/weather_api.dart';
import 'package:level_orm/data/repository/weather_repository_impl.dart';
import 'package:level_orm/presentation/weather_screen.dart';
import 'package:level_orm/presentation/weather_viewmodel.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ChangeNotifierProvider(
        create: (_) => WeatherViewModel(
          repository: WeatherRepositoryImpl(weatherApi: WeatherApi()),
        ),
        child: const WeatherScreen(),
      ),
    );
  }
}
