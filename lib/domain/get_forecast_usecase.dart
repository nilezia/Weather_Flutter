import 'package:my_weather/data/model/forecast_response.dart';
import 'package:my_weather/data/repository/weather_repository.dart';
import 'package:my_weather/domain/model/forecast_weather_ui.dart';
import 'package:my_weather/domain/model/weather_ui.dart';
abstract class GetForecastUseCase {
  Future<ForecastUi> execute(double lat, double lng);
}

class GetForecastUseCaseImpl extends GetForecastUseCase {
  final WeatherRepository repository;

  GetForecastUseCaseImpl(this.repository);

  @override
  Future<ForecastUi> execute(double lat, double lng) async {
    final ForecastResponse response = await repository.getFutureWeather(
        lat, lng);
    final ForecastUi forecastWeatherUi = mapDataToDomain(response);
    return forecastWeatherUi;
  }

  ForecastUi mapDataToDomain(ForecastResponse response) {
    final dailyForecast = response.list
        ?.where((item) => item.dtTxt?.contains("12:00:00") == true)
        .toList()
        ?? [];
    List<WeatherUi> list = dailyForecast.map((it) {
      final weather = it.weather?.isNotEmpty == true ? it.weather!.first : null;
      return WeatherUi(
        mainWeather: weather?.main ?? "",
        temperature: it.main?.temp?.toString() ?? "-",
        humidity: it.main?.humidity?.toString() ?? "-",
        windSpeed: it.wind?.speed?.toString() ?? "-",
        description: weather?.description ?? "",
        feelsLike: it.main?.feelsLike?.toString() ?? "-",
        tempMax: it.main?.tempMax?.toString() ?? "-",
        tempMin: it.main?.tempMin?.toString() ?? "-",
        iconUrl: weather != null
            ? "https://openweathermap.org/img/wn/${weather.icon}@2x.png"
            : "",
      );
    }).toList()?? [];

    return ForecastUi(
        weathers: list
    );
  }
}