import 'package:flutter/material.dart';
import 'package:flutter_weather_app/controllers/weather_controller.dart';
import 'package:flutter_weather_app/utils/constants/theme.dart';
import 'package:flutter_weather_app/views/weather_home_view.dart';
import 'views/daily_weather_view.dart';

import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final weatherController = Get.put(WeatherController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      initialRoute: '/HomeView',
      routes: {
        '/HomeView': (context) => HomeView(),
        '/DailyWeatherView': (context) => const DailyWeatherView(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
