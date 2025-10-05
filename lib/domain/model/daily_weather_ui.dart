import 'package:my_weather/domain/model/weather_ui.dart';

class DailyWeatherUi {
  final String city;
  final String sunrise;
  final String sunset;
  final String country;
  final WeatherUi weatherUi;

  DailyWeatherUi({
    this.city = "",
    this.sunrise = "",
    this.sunset = "",
    this.country = "",
    WeatherUi? weatherUi,
  }) : weatherUi = weatherUi ?? WeatherUi();


  DailyWeatherUi copyWith({
    String? city,
    String? sunrise,
    String? sunset,
    String? country,
    WeatherUi? weatherUi,
  }) {
    return DailyWeatherUi(
      city: city ?? this.city,
      sunrise: sunrise ?? this.sunrise,
      sunset: sunset ?? this.sunset,
      country: country ?? this.country,
      weatherUi: weatherUi ?? this.weatherUi,
    );
  }

  @override
  String toString() {
    return 'DailyWeatherUi(city: $city, sunrise: $sunrise, sunset: $sunset, country: $country, weatherUi: $weatherUi)';
  }
}
