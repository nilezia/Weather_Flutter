import 'dart:convert';
import '../model/weather_response.dart';
import 'package:http/http.dart' as http;

class WeatherApi {
  final String baseUrl = "https://api.openweathermap.org/";
  final String apiKey = "";

  Future<WeatherResponse> getWeather(double lat, double lng) async {
    final response = await http.get(
      Uri.parse(
        "${baseUrl}data/2.5/weather?lat=$lat&lon=$lng&appid=$apiKey&units=metric",
      ),
    );
    if (response.statusCode == 200) {
      return WeatherResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to load weather: ${response.statusCode}");
    }
  }

  Future<WeatherResponse> getForecast(double lat, double lng) async {
    final response = await http.get(
      Uri.parse("${baseUrl}data/2.5/forecast?lat=$lat&lon=$lng&"),
    );
    if (response.statusCode == 200) {
      return WeatherResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to load weather: ${response.statusCode}");
    }
  }
}
