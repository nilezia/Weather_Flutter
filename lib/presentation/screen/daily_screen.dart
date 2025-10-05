import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_weather/presentation/viewmodel/weather_notifier.dart';

class DailyScreen extends ConsumerStatefulWidget {
  const DailyScreen({super.key, required this.title});

  final String title;

  @override
  ConsumerState<DailyScreen> createState() => _DailyScreenState();
}

class _DailyScreenState extends ConsumerState<DailyScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(weatherNotifierProvider.notifier).loadWeather(13.7563, 100.5018);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(weatherNotifierProvider);
    if (state.isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (state.error != null) {
      return errorWidget(state, context);
    }
    return dailyScreenWidget(state);
  }

  Widget temperatureWidget(WeatherState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          spacing: 8,
          children: <Widget>[
            Icon(FontAwesomeIcons.locationPin, color: Colors.white, size: 24),
            Text(
              style: TextStyle(color: Colors.white),
              "${state.dailyWeatherUi.city}",
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          style: TextStyle(color: Colors.white, fontSize: 32),
          "${state.dailyWeatherUi.weatherUi.temperature}°C",
        ),
        SizedBox(height: 8),
        Row(
          spacing: 8,
          children: [
            Text(
              style: TextStyle(color: Colors.white),
              "${state.dailyWeatherUi.weatherUi.mainWeather}",
            ),
            Image.network(
              state.dailyWeatherUi.weatherUi.iconUrl ?? "",
              width: 24,
              height: 24,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.cloud, size: 24, color: Colors.grey);
              },
            ),
          ],
        ),
        SizedBox(height: 16),
        Row(
          spacing: 8,
          children: [
            Text(
              style: TextStyle(color: Colors.white),
              "↑${state.dailyWeatherUi.weatherUi.tempMax}°",
            ),
            Text(
              style: TextStyle(color: Colors.white),
              "↓${state.dailyWeatherUi.weatherUi.tempMin}°",
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          style: TextStyle(color: Colors.white),
          "อุณหภูมิที่รู้สึกได้ ${state.dailyWeatherUi.weatherUi.feelsLike}°C",
        ),
      ],
    );
  }

  Widget cardWind(WeatherState state) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(FontAwesomeIcons.wind, color: Colors.white, size: 18),
                    SizedBox(width: 16),
                    Text(
                      "${state.dailyWeatherUi.weatherUi.windSpeed} m/s",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.droplet,
                      color: Colors.white,
                      size: 18,
                    ),
                    SizedBox(width: 16),
                    Text(
                      "${state.dailyWeatherUi.weatherUi.humidity} %",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(FontAwesomeIcons.sun, color: Colors.white, size: 18),
                    SizedBox(width: 16),
                    Text(
                      state.dailyWeatherUi.sunrise,
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(FontAwesomeIcons.sun, color: Colors.white, size: 18),
                    SizedBox(width: 16),
                    Text(
                      state.dailyWeatherUi.sunset,
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget cardForecast(WeatherState state) {
    return Container();
  }

  Widget dailyScreenWidget(WeatherState state) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          style: const TextStyle(color: Colors.white, fontSize: 24),
          "หนองจอก",
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF90CAF9), // ฟ้าอ่อน
              Color(0xFF2196F3), // ฟ้าเข้ม
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.only(
                top: kToolbarHeight + MediaQuery.of(context).padding.top,
                left: 16,
                right: 16,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    temperatureWidget(state),
                    SizedBox(height: 16),
                    cardWind(state),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget errorWidget(WeatherState state, BuildContext context) {
  return Scaffold(
    extendBodyBehindAppBar: true,
    appBar: AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Text(
        style: const TextStyle(color: Colors.white, fontSize: 24),
        "Something went wrong",
      ),
    ),
    body: Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF90CAF9), // ฟ้าอ่อน
            Color(0xFF2196F3), // ฟ้าเข้ม
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: kToolbarHeight + MediaQuery.of(context).padding.top,
          left: 16,
          right: 16,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text("${state.error}")],
          ),
        ),
      ),
    ),
  );
}
