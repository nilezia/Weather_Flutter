import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_weather/di/di.dart';
import 'package:my_weather/domain/get_daily_weather_use_case.dart';
import 'package:my_weather/domain/model/daily_weather_ui.dart';

class WeatherNotifier extends  StateNotifier<WeatherState> {

  final GetDailyWeatherUseCase useCase;
  WeatherNotifier(this.useCase) : super(WeatherState());

  Future<void> loadWeather(double lat, double lng) async {
    print("loadWeather!");
    state = state.copyWith(isLoading: true);

      try {
        final result = await useCase.execute(lat, lng);
        state = state.copyWith(isLoading: false, dailyWeatherUi: result);
      } catch (e) {
        state = state.copyWith(isLoading: false, error: e.toString());
      }
  }
}

class WeatherState {
  final bool isLoading;
  final DailyWeatherUi dailyWeatherUi;
  final String? error;

  WeatherState({
    this.isLoading = false,
    DailyWeatherUi? dailyWeatherUi,
    this.error,
  }) : dailyWeatherUi = dailyWeatherUi  ?? DailyWeatherUi();

  WeatherState copyWith({
    bool? isLoading,
    DailyWeatherUi? dailyWeatherUi,
    String? error,
  }) {
    return WeatherState(
      isLoading: isLoading ?? this.isLoading,
      dailyWeatherUi: dailyWeatherUi?? this.dailyWeatherUi,
      error: error ?? this.error,
    );
  }
}
final weatherNotifierProvider =
StateNotifierProvider<WeatherNotifier, WeatherState>((ref) {
  final useCase = getIt<GetDailyWeatherUseCase>();
  return WeatherNotifier(useCase);
});