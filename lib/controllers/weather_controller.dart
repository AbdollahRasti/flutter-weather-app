import 'package:flutter/material.dart';
import 'package:flutter_weather_app/services/location_service.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:flutter_weather_app/models/weather_model.dart';
import '../services/weather_service.dart';

class WeatherController extends GetxController {
  final WeatherService _weatherService = WeatherService();
  final LocationService _locationService = LocationService();

  // Observable variables for the weather data
  var isLoading = true.obs;
  var weatherData = WeatherModel(
    address: '',
    resolvedAddress: '',
    latitude: 0.0,
    longitude: 0.0,
    timezone: '',
  ).obs;

  void onInit() {
    super.onInit();
    fetchWeatherByLocation();
  }

  Future<void> fetchWeatherByLocation() async {
    try {
      isLoading(true);

      // Try to get the current location
      Position? position;
      try {
        position = await _locationService.getCurrentLocation();
      } catch (e) {
        print('Error getting current location: $e');
        print('Attempting to use last known location...');
      }

      if (position == null) {
        position = await _locationService.getLastKnownPosition();
        if (position == null) {
          throw Exception(
              'Could not retrieve location (current or last known).');
        }
      }

      var data = await _weatherService.getWeatherWithLatLong(
        position.latitude.toString(),
        position.longitude.toString(),
      );
      // print('Lat and Long Data: ${position.latitude}, ${position.longitude}');
      weatherData.value = data;

      // Check if the address is missing and convert Lat/Lon to address
      if (data.address == null || data.address.isNotEmpty) {
        String resolvedAddress = await _convertLatLonToAddress(
          position.latitude,
          position.longitude,
        );
        weatherData.value.resolvedAddress = resolvedAddress;
        // print('Updated Address from Lat/Lon: $resolvedAddress');
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Could not fetch weather data',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      print('Error fetching weather data: $e');
    } finally {
      isLoading(false);
    }
  }

  // Function to fetch weather data by city name
  Future<void> fetchWeatherByCity(String cityName) async {
    isLoading(true); // Start loading
    try {
      var data = await _weatherService.getWeatherWithCityName(cityName);
      weatherData.value = data;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Could not fetch weather data',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      print('Error fetching weather data: $e');
    } finally {
      isLoading(false); // End loading
    }
  }

  Future<String> _convertLatLonToAddress(double lat, double lon) async {
    // print('Lat and Long: $lat, $lon');
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lon);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        // print('City: ${place.locality}, Country: ${place.country}');
        return '${place.locality}';
      } else {
        return 'Unknown location';
      }
    } catch (e) {
      print('Error converting Lat/Lon to address: $e');
      return 'Unknown location';
    }
  }

  String convertEpochToDateTime(double epochTime, bool showMonth) {
    // Convert epoch time to DateTime
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch((epochTime * 1000).toInt());

    // Define an array of days of the week
    List<String> daysOfWeek = [
      'Sunday',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday'
    ];

    // Define an array of month names without spaces
    List<String> monthsOfYear = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];

    // Get the day of the week
    String dayOfWeek = daysOfWeek[dateTime.weekday - 1]; // weekday is 1-7

    // Format the date and time
    String formattedDate =
        "$dayOfWeek, ${dateTime.day} ${monthsOfYear[dateTime.month - 1]}";

    if (!showMonth) {
      formattedDate = dayOfWeek;
    }
    return formattedDate;
  }
}
