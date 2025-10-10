class ForecastResponse {
  final City? city;
  final int? cnt;
  final String? cod;
  final List<Item>? list;
  final int? message;

  ForecastResponse({
    this.city,
    this.cnt,
    this.cod,
    this.list,
    this.message,
  });

  factory ForecastResponse.fromJson(Map<String, dynamic> json) {
    return ForecastResponse(
      city: json['city'] != null ? City.fromJson(json['city']) : null,
      cnt: json['cnt'],
      cod: json['cod'],
      list: json['list'] != null
          ? (json['list'] as List).map((e) => Item.fromJson(e)).toList()
          : null,
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() => {
    'city': city?.toJson(),
    'cnt': cnt,
    'cod': cod,
    'list': list?.map((e) => e.toJson()).toList(),
    'message': message,
  };
}

class City {
  final Coord? coord;
  final String? country;
  final int? id;
  final String? name;
  final int? population;
  final int? sunrise;
  final int? sunset;
  final int? timezone;

  City({
    this.coord,
    this.country,
    this.id,
    this.name,
    this.population,
    this.sunrise,
    this.sunset,
    this.timezone,
  });

  factory City.fromJson(Map<String, dynamic> json) => City(
    coord: json['coord'] != null ? Coord.fromJson(json['coord']) : null,
    country: json['country'],
    id: json['id'],
    name: json['name'],
    population: json['population'],
    sunrise: json['sunrise'],
    sunset: json['sunset'],
    timezone: json['timezone'],
  );

  Map<String, dynamic> toJson() => {
    'coord': coord?.toJson(),
    'country': country,
    'id': id,
    'name': name,
    'population': population,
    'sunrise': sunrise,
    'sunset': sunset,
    'timezone': timezone,
  };
}

class Coord {
  final double? lat;
  final double? lon;

  Coord({this.lat, this.lon});

  factory Coord.fromJson(Map<String, dynamic> json) => Coord(
    lat: (json['lat'] as num?)?.toDouble(),
    lon: (json['lon'] as num?)?.toDouble(),
  );

  Map<String, dynamic> toJson() => {'lat': lat, 'lon': lon};
}

class Item {
  final Clouds? clouds;
  final int? dt;
  final String? dtTxt;
  final Main? main;
  final double? pop;
  final Rain? rain;
  final Sys? sys;
  final int? visibility;
  final List<Weather>? weather;
  final Wind? wind;

  Item({
    this.clouds,
    this.dt,
    this.dtTxt,
    this.main,
    this.pop,
    this.rain,
    this.sys,
    this.visibility,
    this.weather,
    this.wind,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    clouds: json['clouds'] != null ? Clouds.fromJson(json['clouds']) : null,
    dt: json['dt'],
    dtTxt: json['dt_txt'],
    main: json['main'] != null ? Main.fromJson(json['main']) : null,
    pop: (json['pop'] as num?)?.toDouble(),
    rain: json['rain'] != null ? Rain.fromJson(json['rain']) : null,
    sys: json['sys'] != null ? Sys.fromJson(json['sys']) : null,
    visibility: json['visibility'],
    weather: json['weather'] != null
        ? (json['weather'] as List)
        .map((e) => Weather.fromJson(e))
        .toList()
        : null,
    wind: json['wind'] != null ? Wind.fromJson(json['wind']) : null,
  );

  Map<String, dynamic> toJson() => {
    'clouds': clouds?.toJson(),
    'dt': dt,
    'dt_txt': dtTxt,
    'main': main?.toJson(),
    'pop': pop,
    'rain': rain?.toJson(),
    'sys': sys?.toJson(),
    'visibility': visibility,
    'weather': weather?.map((e) => e.toJson()).toList(),
    'wind': wind?.toJson(),
  };
}

class Weather {
  final String? description;
  final String? icon;
  final int? id;
  final String? main;

  Weather({this.description, this.icon, this.id, this.main});

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
    description: json['description'],
    icon: json['icon'],
    id: json['id'],
    main: json['main'],
  );

  Map<String, dynamic> toJson() =>
      {'description': description, 'icon': icon, 'id': id, 'main': main};
}

// -------------------------
// ด้านล่างคือคลาสย่อยจาก WeatherResponse
// -------------------------

class Clouds {
  final int? all;
  Clouds({this.all});

  factory Clouds.fromJson(Map<String, dynamic> json) => Clouds(all: json['all']);
  Map<String, dynamic> toJson() => {'all': all};
}

class Main {
  final double? temp;
  final double? feelsLike;
  final double? tempMin;
  final double? tempMax;
  final int? pressure;
  final int? humidity;

  Main({
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.humidity,
  });

  factory Main.fromJson(Map<String, dynamic> json) => Main(
    temp: (json['temp'] as num?)?.toDouble(),
    feelsLike: (json['feels_like'] as num?)?.toDouble(),
    tempMin: (json['temp_min'] as num?)?.toDouble(),
    tempMax: (json['temp_max'] as num?)?.toDouble(),
    pressure: json['pressure'],
    humidity: json['humidity'],
  );

  Map<String, dynamic> toJson() => {
    'temp': temp,
    'feels_like': feelsLike,
    'temp_min': tempMin,
    'temp_max': tempMax,
    'pressure': pressure,
    'humidity': humidity,
  };
}

class Rain {
  final double? volume;
  Rain({this.volume});

  factory Rain.fromJson(Map<String, dynamic> json) =>
      Rain(volume: (json['3h'] as num?)?.toDouble());

  Map<String, dynamic> toJson() => {'3h': volume};
}

class Sys {
  final String? pod;
  Sys({this.pod});

  factory Sys.fromJson(Map<String, dynamic> json) => Sys(pod: json['pod']);
  Map<String, dynamic> toJson() => {'pod': pod};
}

class Wind {
  final double? speed;
  final int? deg;

  Wind({this.speed, this.deg});

  factory Wind.fromJson(Map<String, dynamic> json) => Wind(
    speed: (json['speed'] as num?)?.toDouble(),
    deg: json['deg'],
  );

  Map<String, dynamic> toJson() => {'speed': speed, 'deg': deg};
}
