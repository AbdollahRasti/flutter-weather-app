class WeatherModel {
  final String address;
  late String resolvedAddress;
  final double latitude;
  final double longitude;
  final String timezone;
  CurrentWeather? currentWeather;
  List<DailyWeather>? dailyWeather;
  List<HourlyWeather>? hourlyWeather;

  WeatherModel({
    required this.address,
    required this.resolvedAddress,
    required this.latitude,
    required this.longitude,
    required this.timezone,
    this.currentWeather,
    this.dailyWeather,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      address: json['address'] as String? ?? 'Unknown Address',
      resolvedAddress:
          json['resolvedAddress'] as String? ?? 'Unknown Resolved Address',
      latitude: double.tryParse(json['latitude'].toString()) ?? 0.0,
      longitude: double.tryParse(json['longitude'].toString()) ?? 0.0,
      timezone: json['timezone'] as String? ?? 'Unknown Timezone',
      currentWeather: json['currentConditions'] != null
          ? CurrentWeather.fromJson(json['currentConditions'])
          : null,
      dailyWeather: (json['days'] as List?)
          ?.map((dayJson) => DailyWeather.fromJson(dayJson))
          .toList(),
    );
  }
}

class CurrentWeather {
  final double cloudcover;
  final String conditions;
  final String datetime;
  final double humidity;
  final String icon;
  final String sunrise;
  final String sunset;
  late double temp;
  final double windspeed;
  final double datetimeEpoch;

  CurrentWeather({
    required this.cloudcover,
    required this.conditions,
    required this.datetime,
    required this.humidity,
    required this.icon,
    required this.sunrise,
    required this.sunset,
    required this.temp,
    required this.windspeed,
    required this.datetimeEpoch,
  });

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    return CurrentWeather(
      cloudcover: double.tryParse(json['cloudcover']?.toString() ?? '0') ?? 0.0,
      conditions: json['conditions'] as String? ?? 'Unknown Condition',
      datetime: json['datetime'] as String? ?? 'Unknown Datetime',
      humidity: double.tryParse(json['humidity']?.toString() ?? '0') ?? 0.0,
      icon: json['icon'] as String? ?? 'Unknown Icon',
      sunrise: json['sunrise'] as String? ?? 'Unknown Sunrise',
      sunset: json['sunset'] as String? ?? 'Unknown Sunset',
      temp: double.tryParse(json['temp']?.toString() ?? '0') ?? 0.0,
      windspeed: double.tryParse(json['windspeed']?.toString() ?? '0') ?? 0.0,
      datetimeEpoch:
          double.tryParse(json['datetimeEpoch']?.toString() ?? '0') ?? 0.0,
    );
  }
}

class DailyWeather {
  final double cloudcover;
  final String conditions;
  final String datetime;
  final double humidity;
  final String icon;
  final String sunrise;
  final String sunset;
  late double tempMax;
  late double temp;
  late double tempMin;
  final double windspeed;
  final double datetimeEpoch;
  List<HourlyWeather>? hourlyWeather;

  DailyWeather({
    required this.cloudcover,
    required this.conditions,
    required this.datetime,
    required this.humidity,
    required this.icon,
    required this.sunrise,
    required this.sunset,
    required this.temp,
    required this.tempMax,
    required this.tempMin,
    required this.windspeed,
    required this.datetimeEpoch,
    this.hourlyWeather,
  });

  factory DailyWeather.fromJson(Map<String, dynamic> json) {
    return DailyWeather(
      cloudcover: double.tryParse(json['cloudcover']?.toString() ?? '0') ?? 0.0,
      conditions: json['conditions'] as String? ?? 'Unknown Conditions',
      datetime: json['datetime'] as String? ?? 'Unknown Datetime',
      humidity: double.tryParse(json['humidity']?.toString() ?? '0') ?? 0.0,
      icon: json['icon'] as String? ?? 'Unknown Icon',
      sunrise: json['sunrise'] as String? ?? 'Unknown Sunrise',
      sunset: json['sunset'] as String? ?? 'Unknown Sunset',
      tempMax: double.tryParse(json['tempmax']?.toString() ?? '0') ?? 0.0,
      temp: double.tryParse(json['temp']?.toString() ?? '0') ?? 0.0,
      tempMin: double.tryParse(json['tempmin']?.toString() ?? '0') ?? 0.0,
      windspeed: double.tryParse(json['windspeed']?.toString() ?? '0') ?? 0.0,
      datetimeEpoch:
          double.tryParse(json['datetimeEpoch']?.toString() ?? '0') ?? 0.0,
      hourlyWeather: (json['hours'] as List?)
              ?.map((hourJson) => HourlyWeather.fromJson(hourJson))
              .toList() ??
          [], // Capture hourly weather data if present
    );
  }
}

class HourlyWeather {
  final double cloudcover;
  final String conditions;
  final String datetime;
  final double humidity;
  final String icon;
  final String sunrise;
  final String sunset;
  late double temp;
  final double windspeed;
  final double datetimeEpoch;

  HourlyWeather({
    required this.cloudcover,
    required this.conditions,
    required this.datetime,
    required this.humidity,
    required this.icon,
    required this.sunrise,
    required this.sunset,
    required this.temp,
    required this.windspeed,
    required this.datetimeEpoch,
  });

  factory HourlyWeather.fromJson(Map<String, dynamic> json) {
    return HourlyWeather(
      cloudcover: double.tryParse(json['cloudcover']?.toString() ?? '0') ?? 0.0,
      conditions: json['conditions'] as String? ?? 'Unknown Conditions',
      datetime: json['datetime'] as String? ?? 'Unknown Datetime',
      humidity: double.tryParse(json['humidity']?.toString() ?? '0') ?? 0.0,
      icon: json['icon'] as String? ?? 'Unknown Icon',
      sunrise: json['sunrise'] as String? ?? 'Unknown Sunrise',
      sunset: json['sunset'] as String? ?? 'Unknown Sunset',
      temp: double.tryParse(json['temp']?.toString() ?? '0') ?? 0.0,
      windspeed: double.tryParse(json['windspeed']?.toString() ?? '0') ?? 0.0,
      datetimeEpoch:
          double.tryParse(json['datetimeEpoch']?.toString() ?? '0') ?? 0.0,
    );
  }
}
