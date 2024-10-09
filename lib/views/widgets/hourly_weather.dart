import 'package:flutter/material.dart';

Widget hourlyWeather(String time, String icon, String temp) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    margin: const EdgeInsets.symmetric(horizontal: 10),
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color.fromARGB(255, 92, 182, 255),
          Color.fromARGB(255, 17, 74, 218),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.all(Radius.circular(30)),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '${temp.substring(0, 2)}°',
          style: const TextStyle(fontSize: 16, color: Colors.white),
        ),
        Image.asset(
          icon,
          height: 30,
        ),
        Text(
          time,
          style: const TextStyle(color: Colors.white),
        ),
      ],
    ),
  );
}
