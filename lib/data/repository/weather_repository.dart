import 'package:my_weather/data/api/weather_api.dart';
import 'package:my_weather/data/model/weather_response.dart';

abstract class WeatherRepository {
  Future<WeatherResponse> getWeather(double lat, double lng);
}

class WeatherRepositoryImpl extends WeatherRepository {
  final WeatherApi api;
  WeatherRepositoryImpl(this.api);

  @override
  Future<WeatherResponse> getWeather(double lat, double lng) async {
    return api.getWeather(lat, lng);
  }
}

