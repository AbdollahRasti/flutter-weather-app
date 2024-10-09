class WeatherConstants {
  // Visualcrossing api key
  static const String apiKey = 'YourVisualCrossingWeatherAPIKeyHere';

  // Weather icons
  static const String humadityIcon = 'assets/icons/humidity_icon.png';
  static const String rainIcon = 'assets/icons/rain_icon.png';
  static const String windIcon = 'assets/icons/wind_icon.png';
  static const String sunnyIcon = 'assets/weather_conditions/sunny.png';

  // Weather Conditions
  static const String clearNight = 'clear-night';
  static const String rain = 'rain';
  static const String cloudy = 'cloudy';
  static const String sunny = 'clear-day';
  static const String partlyCloudyDay = 'partly-cloudy-day';
  static const String partlyCloudyNight = 'partly-cloudy-night';
  static const String snow = 'snow';
  static const String fog = 'fog';
  static const String wind = 'wind';

  static String getWeatherIcon(String iconName) {
    switch (iconName) {
      case clearNight:
        return 'assets/weather_conditions/clear_night.png';
      case rain:
        return 'assets/weather_conditions/rain.png';
      case cloudy:
        return 'assets/weather_conditions/cloudy.png';
      case sunny:
        return 'assets/weather_conditions/sunny.png';
      case partlyCloudyDay:
        return 'assets/weather_conditions/sun_cloudy.png';
      case partlyCloudyNight:
        return 'assets/weather_conditions/night_cloudy.png';
      case snow:
        return 'assets/weather_conditions/snow.png';
      case fog:
        return 'assets/weather_conditions/fog.png';
      case wind:
        return 'assets/weather_conditions/wind.png';
      default:
        return 'assets/weather_conditions/sunny.png';
    }
  }
}
