import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_weather/di/di.dart';
import 'package:my_weather/domain/get_daily_weather_usecase.dart';
import 'package:my_weather/domain/get_forecast_usecase.dart';
import 'package:my_weather/domain/model/daily_weather_ui.dart';
import 'package:my_weather/domain/model/forecast_weather_ui.dart';

class WeatherNotifier extends StateNotifier<WeatherState> {
  final GetDailyWeatherUseCase getDailyWeatherUseCase;
  final GetForecastUseCase getForecastWeatherUseCase;

  WeatherNotifier(this.getDailyWeatherUseCase, this.getForecastWeatherUseCase)
    : super(WeatherState());

  Future<void> loadWeather(double lat, double lng) async {
    print("loadWeather!");
    state = state.copyWith(isLoading: true);

    try {
      final result = await getDailyWeatherUseCase.execute(lat, lng);
      state = state.copyWith(isLoading: false, dailyWeatherUi: result);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> loadForecastWeather(double lat, double lng) async {
    state = state.copyWith(isLoading: true);

    try {
      final result = await getForecastWeatherUseCase.execute(lat, lng);
      state = state.copyWith(isLoading: false, forecastWeatherUi: result);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}

class WeatherState {
  final bool isLoading;
  final DailyWeatherUi dailyWeatherUi;
  final ForecastUi forecastWeatherUi;
  final String? error;

  WeatherState({
    this.isLoading = false,
    DailyWeatherUi? dailyWeatherUi,
    ForecastUi? forecastWeatherUi,
    this.error,
  }) : dailyWeatherUi = dailyWeatherUi ?? DailyWeatherUi(),
       forecastWeatherUi = forecastWeatherUi ?? ForecastUi();

  WeatherState copyWith({
    bool? isLoading,
    DailyWeatherUi? dailyWeatherUi,
    String? error,
    ForecastUi? forecastWeatherUi,
  }) {
    return WeatherState(
      isLoading: isLoading ?? this.isLoading,
      dailyWeatherUi: dailyWeatherUi ?? this.dailyWeatherUi,
      forecastWeatherUi: forecastWeatherUi ?? this.forecastWeatherUi,
      error: error ?? this.error,
    );
  }
}

final weatherNotifierProvider =
    StateNotifierProvider<WeatherNotifier, WeatherState>((ref) {
      final getDailyWeatherUseCase = getIt<GetDailyWeatherUseCase>();
      final getForecastWeatherUseCase = getIt<GetForecastUseCase>();
      return WeatherNotifier(getDailyWeatherUseCase, getForecastWeatherUseCase);
    });
