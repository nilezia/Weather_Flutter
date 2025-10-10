import 'dart:convert';
import '../model/weather_response.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../model/forecast_response.dart';

class WeatherApi {
  final String baseUrl = "https://api.openweathermap.org/";
  final String apiKey = dotenv.env['API_KEY'] ?? "";

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

  Future<ForecastResponse> getForecast(double lat, double lng) async {
    print(apiKey);

    final response = await http.get(
      Uri.parse("${baseUrl}data/2.5/forecast?lat=$lat&lon=$lng&appid=$apiKey"),
    );
    if (response.statusCode == 200) {
      return ForecastResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to load weather: ${response.statusCode}");
    }
  }
}
