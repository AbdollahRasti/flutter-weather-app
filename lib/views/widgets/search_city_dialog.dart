import 'package:flutter/material.dart';
import 'package:flutter_weather_app/controllers/weather_controller.dart';
import 'package:flutter_weather_app/utils/constants/theme.dart';
import 'package:get/get.dart';

class SearchLocationButton extends StatelessWidget {
  final TextEditingController searchCityController;
  final WeatherController weatherController;

  const SearchLocationButton({
    Key? key,
    required this.searchCityController,
    required this.weatherController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Get.dialog(
          AlertDialog(
            backgroundColor: AppTheme.darkBlue.withOpacity(0.6),
            title: const Text(
              'Search Location',
              style: TextStyle(color: Colors.white),
            ),
            content: TextField(
              controller: searchCityController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Enter Location',
                labelStyle: TextStyle(color: Colors.white),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  if (searchCityController.text.isNotEmpty) {
                    weatherController
                        .fetchWeatherByCity(searchCityController.text);
                  }
                  Get.back();
                },
                child: const Text(
                  'Search',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        );
      },
      icon: const Icon(
        Icons.search,
        size: 28,
        color: Colors.white,
      ),
    );
  }
}
