class WeatherData {
  Coord? coord;
  List<WeatherList>? list;

  WeatherData({this.coord, this.list});

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      coord: Coord.fromJson(json['coord']),
      list: List<WeatherList>.from(
          json['list'].map((x) => WeatherList.fromJson(x))),
    );
  }
}

class Coord {
  double? lon;
  double? lat;

  Coord({this.lon, this.lat});

  factory Coord.fromJson(Map<String, dynamic> json) {
    return Coord(
      lon: json['lon'].toDouble(),
      lat: json['lat'].toDouble(),
    );
  }
}

class WeatherList {
  Main? main;
  Components? components;
  int? dt;

  WeatherList({this.main, this.components, this.dt});

  factory WeatherList.fromJson(Map<String, dynamic> json) {
    return WeatherList(
      main: Main.fromJson(json['main']),
      components: Components.fromJson(json['components']),
      dt: json['dt'],
    );
  }
}

class Main {
  int? aqi;

  Main({this.aqi});

  factory Main.fromJson(Map<String, dynamic> json) {
    return Main(
      aqi: json['aqi'],
    );
  }
}

class Components {
  double? co;
  double? no;
  double? no2;
  double? o3;
  double? so2;
  double? pm2_5;
  double? pm10;
  double? nh3;

  Components({
    this.co,
    this.no,
    this.no2,
    this.o3,
    this.so2,
    this.pm2_5,
    this.pm10,
    this.nh3,
  });

  factory Components.fromJson(Map<String, dynamic> json) {
    return Components(
      co: json['co'].toDouble(),
      no: json['no'].toDouble(),
      no2: json['no2'].toDouble(),
      o3: json['o3'].toDouble(),
      so2: json['so2'].toDouble(),
      pm2_5: json['pm2_5'].toDouble(),
      pm10: json['pm10'].toDouble(),
      nh3: json['nh3'].toDouble(),
    );
  }
}
