import 'package:get/get.dart';
import 'package:flutter_weather_app/models/weather_model.dart';

class TemperatureController extends GetxController {
  var isFahrenheit = false.obs;

  void toggleTemperatureUnit(WeatherModel weatherData) {
    if (isFahrenheit.value) {
      _convertToCelsius(weatherData);
    } else {
      _convertToFahrenheit(weatherData);
    }
    isFahrenheit.value = !isFahrenheit.value;
  }

  // Convert a single Celsius temperature to Fahrenheit
  double _convertToFahrenheitTemp(double tempInCelsius) {
    return (tempInCelsius * 9 / 5) + 32;
  }

  // Convert a single Fahrenheit temperature to Celsius
  double _convertToCelsiusTemp(double tempInFahrenheit) {
    return (tempInFahrenheit - 32) * 5 / 9;
  }

  // Convert all temperatures in the weather data to Fahrenheit
  void _convertToFahrenheit(WeatherModel weatherData) {
    // Convert current temperature
    weatherData.currentWeather?.temp =
        _convertToFahrenheitTemp(weatherData.currentWeather!.temp);

    // Convert daily temperatures
    for (var daily in weatherData.dailyWeather!) {
      daily.tempMax = _convertToFahrenheitTemp(daily.tempMax);
      daily.tempMin = _convertToFahrenheitTemp(daily.tempMin);
    }

    // Convert hourly temperatures
    for (var hourly in weatherData.hourlyWeather!) {
      hourly.temp = _convertToFahrenheitTemp(hourly.temp);
    }
  }

  void _convertToCelsius(WeatherModel weatherData) {
    // Convert current temperature
    weatherData.currentWeather?.temp =
        _convertToCelsiusTemp(weatherData.currentWeather!.temp);

    // Convert daily temperatures
    for (var daily in weatherData.dailyWeather!) {
      daily.tempMax = _convertToCelsiusTemp(daily.tempMax);
      daily.tempMin = _convertToCelsiusTemp(daily.tempMin);
    }

    // Convert hourly temperatures
    for (var hourly in weatherData.hourlyWeather!) {
      hourly.temp = _convertToCelsiusTemp(hourly.temp);
    }
  }
}
