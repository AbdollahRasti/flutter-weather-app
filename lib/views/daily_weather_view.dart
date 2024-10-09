import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_weather_app/controllers/weather_controller.dart';
import 'package:flutter_weather_app/utils/constants/weather_constants.dart';
import 'package:get/get.dart';
import 'widgets/current_weather_details.dart';
import 'widgets/single_daily_weather.dart';

class DailyWeatherView extends StatefulWidget {
  const DailyWeatherView({super.key});

  @override
  _DailyWeatherViewState createState() => _DailyWeatherViewState();
}

class _DailyWeatherViewState extends State<DailyWeatherView> {
  final WeatherController weatherController = Get.put(WeatherController());

  late ScrollController _scrollController;
  bool _isAppBarVisible = true;

  String weatherIconPath = '';

  int _itemsToShow = 7;
  final int _incrementItems = 7;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);

    // Get the icon name from the JSON
    var currentWeather = weatherController.weatherData.value.currentWeather;
    if (currentWeather != null) {
      String iconName = currentWeather.icon;

      // Get the corresponding icon path or default icon path
      weatherIconPath = WeatherConstants.getWeatherIcon(iconName);
    }
  }

  void _scrollListener() {
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      if (_isAppBarVisible) {
        setState(() {
          _isAppBarVisible = false;
        });
      }
    } else if (_scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      if (!_isAppBarVisible) {
        setState(() {
          _isAppBarVisible = true;
        });
      }
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final weatherData = weatherController.weatherData.value!;

    double height = MediaQuery.of(context).size.height;

    int todayEpoch = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    // Filter dailyWeather to include only today and future days
    var futureDailyWeather = weatherData.dailyWeather!
        .where((dailyWeather) => dailyWeather.datetimeEpoch >= todayEpoch)
        .toList();

    return Scaffold(
      body: Stack(
        children: [
          // Daily Weather List
          Padding(
            padding: EdgeInsets.only(top: _isAppBarVisible ? height / 2 : 0),
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _itemsToShow < futureDailyWeather.length
                  ? _itemsToShow + 1
                  : _itemsToShow,
              itemBuilder: (context, index) {
                if (index < _itemsToShow) {
                  var dailyWeather = futureDailyWeather[index];
                  return singleDailyWeather(
                    // date
                    weatherController.convertEpochToDateTime(
                      dailyWeather.datetimeEpoch,
                      false,
                    ),
                    // icon
                    WeatherConstants.getWeatherIcon(dailyWeather.conditions),
                    // condition
                    dailyWeather.conditions,
                    // max temp
                    dailyWeather.tempMax.toStringAsFixed(0),
                    // min temp
                    dailyWeather.tempMin.toStringAsFixed(0),
                  );
                } else {
                  // Show "Load More" button
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _itemsToShow += _incrementItems;
                        });
                      },
                      child: const Text('Load More'),
                    ),
                  );
                }
              },
            ),
          ),

          // Animated AppBar container
          AnimatedContainer(
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
            duration: const Duration(milliseconds: 400),
            height: _isAppBarVisible ? height / 2 : 0,
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // app bar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: const Icon(
                            Icons.arrow_circle_left_outlined,
                            color: Colors.white,
                            size: 36,
                          )),
                      const SizedBox()
                    ],
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.calendar_month_sharp,
                        size: 26,
                        color: Colors.white,
                      ),
                      SizedBox(width: 6),
                      Text(
                        textAlign: TextAlign.center,
                        '7 Days',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height / 22),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          weatherIconPath,
                          width: height / 6,
                        ),
                        // SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Tomorrow',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Text.rich(TextSpan(
                              children: [
                                TextSpan(
                                  text: weatherController.weatherData.value
                                      .dailyWeather![1].tempMax
                                      .toStringAsFixed(0),
                                  style: const TextStyle(
                                    fontSize: 38,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      '/${weatherController.weatherData.value.dailyWeather![1].tempMin.toStringAsFixed(0)}°',
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            )),
                            Text(
                              weatherController.weatherData.value
                                  .dailyWeather![1].conditions,
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.white),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  // const SizedBox(height: 20),
                  const Divider(
                    color: Colors.white,
                    thickness: 1,
                    endIndent: 25,
                    indent: 25,
                  ),
                  currentWeatherDetails(
                    weatherController
                        .weatherData.value.dailyWeather![1].windspeed
                        .toString(),
                    weatherController
                        .weatherData.value.dailyWeather![1].humidity
                        .toString(),
                    weatherController
                        .weatherData.value.dailyWeather![1].cloudcover
                        .toString(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
