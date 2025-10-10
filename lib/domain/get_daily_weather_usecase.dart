import 'package:my_weather/data/model/weather_response.dart';
import 'package:my_weather/data/repository/weather_repository.dart';
import 'package:my_weather/domain/model/daily_weather_ui.dart';
import 'package:my_weather/domain/model/weather_ui.dart';
import 'package:intl/intl.dart';
import 'package:collection/collection.dart';


abstract class GetDailyWeatherUseCase {
  Future<DailyWeatherUi> execute(double lat, double lng);
}

class GetDailyWeatherUseCaseImpl extends GetDailyWeatherUseCase {
  final WeatherRepository repository;

  GetDailyWeatherUseCaseImpl(this.repository);

  @override
  Future<DailyWeatherUi> execute(double lat, double lng) async {
    final result = await repository.getWeather(lat, lng);
    final dailyWeatherUi = mapDataToDomain(result);
    return dailyWeatherUi;
  }

  // แปลง WeatherResponse → WeatherUi
  DailyWeatherUi mapDataToDomain(WeatherResponse result) {
    return DailyWeatherUi(
      city: result.name?.toString() ?? "0",
      sunrise: formatTimestamp(result.sys?.sunset),
      sunset: formatTimestamp(result.sys?.sunrise),

      weatherUi : WeatherUi(
      mainWeather: result.weather?.first.main ?? "N/A",
      temperature: result.main?.temp.toString() ?? "0",
      humidity: result.main?.humidity.toString() ?? "0",
      windSpeed: result.wind?.speed.toString() ?? "0",
      description: result.weather?.first.description ?? "N/A",
      feelsLike: result.main?.feels_like.toString() ?? "0",
      tempMax: result.main?.temp_max.toString() ?? "0",
      tempMin: result.main?.temp_min.toString() ?? "0",
      iconUrl:"https://openweathermap.org/img/wn/${result.weather?.firstOrNull?.icon}@2x.png",)
    );
  }
}
String formatTimestamp(int? timestamp) {
  if (timestamp == null) return "N/A";
  DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);

  return DateFormat('HH:mm').format(date); // หรือ 'hh:mm a' ถ้า 12 ชั่วโมง
}