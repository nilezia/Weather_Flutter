class WeatherUi {
  final String? mainWeather;
  final String? temperature;
  final String? humidity;
  final String? windSpeed;
  final String? description;
  final String? iconUrl;
  final String? feelsLike;
  final String? tempMax;
  final String? tempMin;

  WeatherUi({
    String? mainWeather,
    String? temperature,
    String? humidity,
    String? windSpeed,
    String? description,
    String? iconUrl,
    String? feelsLike,
    String? tempMax,
    String? tempMin,
  })  : mainWeather = mainWeather ?? "",
        temperature = temperature ?? "0",
        humidity = humidity ?? "",
        windSpeed = windSpeed ?? "",
        description = description ?? "",
        iconUrl = iconUrl ?? "",
        feelsLike = feelsLike ?? "0",
        tempMax = tempMax ?? "0",
        tempMin = tempMin ?? "0";

  // copyWith สำหรับ immutability
  WeatherUi copyWith({
    String? mainWeather,
    String? temperature,
    String? humidity,
    String? windSpeed,
    String? description,
    String? iconUrl,
    String? feelsLike,
    String? tempMax,
    String? tempMin,
  }) {
    return WeatherUi(
      mainWeather: mainWeather ?? this.mainWeather,
      temperature: temperature ?? this.temperature,
      humidity: humidity ?? this.humidity,
      windSpeed: windSpeed ?? this.windSpeed,
      description: description ?? this.description,
      iconUrl: iconUrl ?? this.iconUrl,
      feelsLike: feelsLike ?? this.feelsLike,
      tempMax: tempMax ?? this.tempMax,
      tempMin: tempMin ?? this.tempMin,
    );
  }

  @override
  String toString() {
    return 'WeatherUi(mainWeather: $mainWeather, temperature: $temperature, humidity: $humidity, windSpeed: $windSpeed, description: $description, iconUrl: $iconUrl, feelsLike: $feelsLike, tempMax: $tempMax, tempMin: $tempMin)';
  }
}
