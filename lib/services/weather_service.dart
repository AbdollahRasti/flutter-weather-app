// lib/data/services/weather_service.dart

import 'dart:convert';
import 'package:flutter_weather_app/models/weather_model.dart';
import 'package:flutter_weather_app/utils/constants/weather_constants.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  final apiKey = WeatherConstants.apiKey;

  // Fetch weather data from API based on the city name
  Future<WeatherModel> getWeatherWithCityName(String cityName) async {
    final url =
        'https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/$cityName?unitGroup=metric&include=events,hours,days,current&key=$apiKey&contentType=json';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      // print(jsonData);
      return _parseWeatherData(jsonData);
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  // Fetch weather data from API based on latitude and longitude
  Future<WeatherModel> getWeatherWithLatLong(String lat, String long) async {
    final url =
        'https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/$lat,$long?unitGroup=metric&include=events,hours,days,current&key=$apiKey&contentType=json';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return _parseWeatherData(jsonData);
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  // Parse the JSON data into WeatherModel and associated weather classes
  WeatherModel _parseWeatherData(Map<String, dynamic> jsonData) {
    // Initialize WeatherModel using basic address details
    final WeatherModel weatherModel = WeatherModel.fromJson(jsonData);

    // Check if 'currentConditions' exists and parse current weather from it
    if (jsonData['currentConditions'] != null) {
      final currentConditions = jsonData['currentConditions'];

      // Set currentWeather from currentConditions data
      weatherModel.currentWeather = CurrentWeather(
        cloudcover: currentConditions['cloudcover']?.toDouble() ?? 0.0,
        conditions: currentConditions['conditions'] ?? '',
        datetime: currentConditions['datetime'] ?? '',
        humidity: currentConditions['humidity']?.toDouble() ?? 0.0,
        icon: currentConditions['icon'] ?? '',
        sunrise: currentConditions['sunrise'] ?? '',
        sunset: currentConditions['sunset'] ?? '',
        temp: currentConditions['temp']?.toDouble() ?? 0.0,
        windspeed: currentConditions['windspeed']?.toDouble() ?? 0.0,
        datetimeEpoch: currentConditions['datetimeEpoch']?.toDouble() ?? 0.0,
      );
    }

    // Parse daily forecast
    if (jsonData['days'] is List && jsonData['days'].isNotEmpty) {
      weatherModel.dailyWeather = (jsonData['days'] as List)
          .map((dayJson) => DailyWeather.fromJson(dayJson))
          .toList();

      // Parse hourly forecast from the first day's hours
      weatherModel.hourlyWeather = (jsonData['days'][0]['hours'] as List)
          .map((hourJson) => HourlyWeather.fromJson(hourJson))
          .toList();
    }

    return weatherModel;
  }
}
