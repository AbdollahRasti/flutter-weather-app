# Flutter Weather App 🌦️

A beautiful and simple weather app built using Flutter. This app provides real-time weather updates, hourly forecasts, and a 7-day forecast based on the user's location or any searched city. The app also supports both light and dark mode and utilizes the powerful **GetX** package for state management.

## Features 🌟

- **Light and Dark Mode**: Switch seamlessly between light and dark themes based on your device's settings or manually through the app's settings.
  
- **GetX State Management**: Efficient and responsive state management using **GetX**, ensuring smooth user interaction and performance.

- **Location-based Weather**: Automatically fetches weather data for your current location using your device's GPS.

- **Search City Weather**: Search for any city worldwide to get current weather, hourly forecasts, and 7-day weather predictions.

- **Hourly & Daily Weather Forecast**: Get a detailed hourly forecast for the next 24 hours, along with a 7-day weather overview.

## Screenshots 📸

<div>
  <img src="https://github.com/AbdollahRasti/flutter-weather-app/blob/main/screenShots/1.png" width="45%" style="display: inline-block; margin-right: 5%;" />
  
  <img src="https://github.com/AbdollahRasti/flutter-weather-app/blob/main/screenShots/2.png" width="45%" style="display: inline-block;" />
</div>
<div></div>
<div>
  <img src="https://github.com/AbdollahRasti/flutter-weather-app/blob/main/screenShots/3.png" width="45%" style="display: inline-block; margin-right: 5%;" />
  
  <img src="https://github.com/AbdollahRasti/flutter-weather-app/blob/main/screenShots/4.png" width="45%" style="display: inline-block;" />
</div>


## Getting Started 🚀

To run this project locally, follow these steps:

### Prerequisites

- Flutter SDK: [Install Flutter](https://flutter.dev/docs/get-started/install) 
- A code editor, preferably [Visual Studio Code](https://code.visualstudio.com/) or [Android Studio](https://developer.android.com/studio)

### Setup

1. **Clone the repository**:

   ```bash
   git clone https://github.com/yourusername/flutter-weather-app.git
   cd flutter-weather-app
   ```

2. **Install dependencies**:

   Run the following command to install all required Flutter packages:

   ```bash
   flutter pub get
   ```

3. **Set up API Key**:

   The app uses the **Visual Crossing Weather API**. To run the app, you'll need to create an account on [Visual Crossing](https://www.visualcrossing.com/) and get your API key. Once you have it, add the API key to the appropriate location in your code (usually in the `weather_constants.dart` file under `lib/utils/constants`).

4. **Run the app**:

   You can run the app on a connected device or simulator/emulator by running the following command:

   ```bash
   flutter run
   ```

### Directory Structure

Here's a quick overview of the main directories:

- **lib/**: Contains all the Dart files for the app
  - **controllers/**: GetX controllers for managing the app's state
  - **services/**: Service for fetching weather data from the API
  - **models/**: Data models for current, hourly, and daily weather forecasts
  - **views/**: All the UI screens of the app
  - **utils/**: Contains constants and utilities like themes and API keys

## API Used 🌐

The app fetches weather data using the [Visual Crossing Weather API](https://www.visualcrossing.com/weather-api).

## Dependencies 🛠️

This app is built using several Flutter packages:

- **[GetX](https://pub.dev/packages/get)**: For state management and routing.
- **[http](https://pub.dev/packages/http)**: To handle HTTP requests.
- **[Geolocator](https://pub.dev/packages/geolocator)**: For accessing the device's location.
- **[Flutter Launcher Icons](https://pub.dev/packages/flutter_launcher_icons)**: For customizing app launcher icons.

## License 📄

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contributing 🤝

Contributions are always welcome! If you find any bugs or have ideas for improvements, feel free to open an issue or submit a pull request.
