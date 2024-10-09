import 'package:flutter/material.dart';
import 'package:flutter_weather_app/controllers/temperature_controller.dart';
import 'package:flutter_weather_app/controllers/weather_controller.dart';
import 'package:flutter_weather_app/utils/constants/weather_constants.dart';
import 'package:flutter_weather_app/views/widgets/current_weather_details.dart';
import 'package:flutter_weather_app/views/widgets/loading_widget.dart';
import 'package:get/get.dart';

import 'widgets/hourly_weather.dart';
import 'widgets/search_city_dialog.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final WeatherController weatherController = Get.put(WeatherController());
  final TemperatureController temperatureController =
      Get.put(TemperatureController());

  TextEditingController searchCityController = TextEditingController();

  double height = 0;
  double width = 0;

  String weatherIconPath = '';

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: Obx(() {
          var currentWeather =
              weatherController.weatherData.value.currentWeather;

          if (currentWeather != null) {
            // Get the icon name from the JSON
            String iconName = currentWeather.icon;

            // Get the corresponding icon path or default icon path
            weatherIconPath = WeatherConstants.getWeatherIcon(iconName);
          }

          if (weatherController.isLoading.value) {
            return const LoadingWidget();
          } else if (currentWeather == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'No weather data available!',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const Text(
                    'Try again',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      weatherController.fetchWeatherByLocation();
                    },
                    child: const Text('Try Again'),
                  ),
                ],
              ),
            );
          } else {
            final weatherData = weatherController.weatherData.value!;

            int currentHour = DateTime.now().hour;

            // Filter the hourly data from now to 23:00
            var filteredHourlyData = weatherData.hourlyWeather!.where((hourly) {
              int hour = int.parse(hourly.datetime.substring(0, 2));
              return hour >= currentHour;
            }).toList();

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Weather Info Container
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF73AEF5),
                          Color(0xFF61A4F1),
                          Color(0xFF478DE0),
                          Color(0xFF398AE5),
                          Color.fromARGB(255, 13, 71, 230),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // App bar
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () {
                                // Toggle between Celsius and Fahrenheit
                                temperatureController
                                    .toggleTemperatureUnit(weatherData);
                              },
                              child: Text(
                                temperatureController.isFahrenheit.value
                                    ? '℉'
                                    : '℃',
                                style: const TextStyle(
                                    fontSize: 28,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),

                            // search city dialog
                            SearchLocationButton(
                              searchCityController: searchCityController,
                              weatherController: weatherController,
                            )
                          ],
                        ),

                        const SizedBox(height: 20),

                        Wrap(
                          alignment: WrapAlignment.center,
                          children: [
                            const Icon(
                              Icons.location_on,
                              size: 32,
                              color: Colors.white,
                            ),
                            Text(
                              textAlign: TextAlign.center,
                              weatherData.resolvedAddress,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Image.asset(
                          weatherIconPath,
                          width: width / 1.8,
                        ),
                        Text(
                          '${weatherData.currentWeather?.temp.toStringAsFixed(0)}°',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${weatherData.currentWeather?.conditions}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.yellow.shade400,
                            fontSize: 38,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          weatherController.convertEpochToDateTime(
                              weatherData.currentWeather!.datetimeEpoch, true),
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Divider(
                          color: Colors.white,
                          thickness: 1,
                          endIndent: 25,
                          indent: 25,
                        ),
                        currentWeatherDetails(
                          weatherData.currentWeather!.windspeed.toString(),
                          weatherData.currentWeather!.humidity.toString(),
                          weatherData.currentWeather!.cloudcover.toString(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Today and 7-Day Forecast
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Today',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.toNamed('/DailyWeatherView');
                          },
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '7 Days',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  SizedBox(
                    height: height / 6.5,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: filteredHourlyData.length,
                      itemBuilder: (context, index) {
                        var hourlyData = filteredHourlyData[index];

                        return hourlyWeather(
                          hourlyData.datetime.substring(0, 5),
                          WeatherConstants.getWeatherIcon(
                            hourlyData.icon,
                          ),
                          '${hourlyData.temp}°',
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          }
        }),
      ),
    );
  }
}
