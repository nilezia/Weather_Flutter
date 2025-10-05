import 'dart:ffi';

class WeatherResponse {
  final String? base;
  final Coord? coord;
  final Main? main;
  final String? name;
  final List<Weather>? weather;
  final Wind? wind;
  final Sys? sys;

  WeatherResponse({
    this.base,
    this.coord,
    this.main,
    this.name,
    this.weather,
    this.wind,
    this.sys
  });

  // ✅ แปลงจาก JSON → Dart Object
  factory WeatherResponse.fromJson(Map<String, dynamic> json) {
    return WeatherResponse(
      base: json['base'] as String?,
      coord: json['coord'] != null ? Coord.fromJson(json['coord']) : null,
      main: json['main'] != null ? Main.fromJson(json['main']) : null,
      name: json['name'] as String?,
      weather: (json['weather'] as List<dynamic>?)
          ?.map((e) => Weather.fromJson(e))
          .toList(),
      wind: json['wind'] != null ? Wind.fromJson(json['wind']) : null,
      sys: json['sys'] != null ? Sys.fromJson(json['sys']) : null,
    );
  }

  // ✅ แปลงจาก Dart Object → JSON
  Map<String, dynamic> toJson() {
    return {
      'base': base,
      'coord': coord?.toJson(),
      'main': main?.toJson(),
      'name': name,
      'weather': weather?.map((e) => e.toJson()).toList(),
      'wind': wind?.toJson(),
      'sys': sys?.toJson(),
    };
  }
}

// ------------------ Sub Models ------------------

class Coord {
  final double? lat;
  final double? lon;

  Coord({this.lat, this.lon});

  factory Coord.fromJson(Map<String, dynamic> json) {
    return Coord(
      lat: (json['lat'] as num?)?.toDouble(),
      lon: (json['lon'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'lon': lon,
    };
  }
}

class Main {
  final double? temp;
  final int? humidity;
  final double? feels_like;
  final double? temp_max;
  final double? temp_min;



  Main({this.temp, this.humidity,this.feels_like, this.temp_max, this.temp_min,} );

  factory Main.fromJson(Map<String, dynamic> json) {
    return Main(
      temp: (json['temp'] as num?)?.toDouble(),
      humidity: json['humidity'] as int?,
      feels_like: (json['feels_like'] as num?)?.toDouble(),
      temp_max: (json['temp_max'] as num?)?.toDouble(),
      temp_min: (json['temp_min'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'temp': temp,
      'humidity': humidity,
      'feels_like': feels_like,
      'temp_max': temp_max,
      'temp_min': temp_min,
    };
  }
}

class Weather {
  final String? main;
  final String? description;
  final String? icon;


  Weather({this.main, this.description, this.icon});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      main: json['main'] as String?,
      description: json['description'] as String?,
      icon: json['icon'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'main': main,
      'description': description,
      'icon': icon,
    };
  }
}

class Wind {
  final double? speed;

  Wind({this.speed});

  factory Wind.fromJson(Map<String, dynamic> json) {
    return Wind(
      speed: (json['speed'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'speed': speed,
    };
  }
}

class Sys {
  final int? sunrise;
  final int? sunset;

  Sys({this.sunrise, this.sunset
  });

  factory Sys.fromJson(Map<String, dynamic> json) {
    return Sys(
      sunrise: json['sunrise'] as int?,
      sunset: json['sunset'] as int?,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'sunrise': sunrise,
      'sunset': sunset,
    };
  }
}