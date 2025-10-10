import 'package:my_weather/domain/model/weather_ui.dart';

class ForecastUi {
  final List<WeatherUi> weathers;
  const ForecastUi({
    this.weathers = const [],

  });

  // ✅ copyWith method
  ForecastUi copyWith({
    List<WeatherUi>? weather,
  }) {
    return ForecastUi(
      weathers: weather ?? this.weathers,
    );
  }

  @override
  String toString() => 'ForecastUi(list: $weathers)';
}
