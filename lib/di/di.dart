import 'package:get_it/get_it.dart';
import 'package:my_weather/data/api/weather_api.dart';
import 'package:my_weather/data/repository/weather_repository.dart';
import 'package:my_weather/domain/get_daily_weather_use_case.dart';

final getIt = GetIt.instance;

void setup(){
  getIt.registerLazySingleton<WeatherRepository>(() => WeatherRepositoryImpl(getIt<WeatherApi>()));
  getIt.registerLazySingleton<GetDailyWeatherUseCase>(
          () => GetDailyWeatherUseCaseImpl(getIt<WeatherRepository>())
  );
  getIt.registerLazySingleton<WeatherApi>(() => WeatherApi());

}