import 'package:flutter/material.dart';
import 'package:flutter_weather_app/utils/constants/weather_constants.dart';

Widget currentWeatherDetails(String wind, String humidity, String rain) {
  return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /////////////////////////////////
          Column(children: [
            Image.asset(
              WeatherConstants.windIcon,
              width: 24,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              '$wind km/h',
              style: const TextStyle(color: Colors.white),
            ),
            const Text(
              'Wind',
              style: TextStyle(color: Colors.white70),
            ),
          ]),

          /////////////////////////////////
          Column(children: [
            Image.asset(
              WeatherConstants.humadityIcon,
              width: 24,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              '$humidity %',
              style: const TextStyle(color: Colors.white),
            ),
            const Text(
              'Humidity',
              style: TextStyle(color: Colors.white70),
            ),
          ]),

          /////////////////////////////////
          Column(children: [
            Image.asset(
              WeatherConstants.rainIcon,
              width: 24,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              '$rain %',
              style: const TextStyle(color: Colors.white),
            ),
            const Text(
              'Chanse of rain',
              style: TextStyle(color: Colors.white70),
            ),
          ]),
        ],
      ));
}
