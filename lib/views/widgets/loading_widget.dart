import 'package:flutter/material.dart';
import 'package:flutter_weather_app/utils/constants/weather_constants.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            WeatherConstants.sunnyIcon,
            width: 250,
          ),
          const CircularProgressIndicator(),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
