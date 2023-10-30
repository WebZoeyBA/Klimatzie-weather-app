import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:klimatzie/models/hourly.dart' as hourly;
import 'package:klimatzie/models/mainweather.dart' as mainweather;
import 'package:klimatzie/models/pollution.dart' as pollution;

class WeatherApi {
  String apiKey = '8d2c65d9e536a8efe0bcadcc9453209e';
  String apiKeyOne = '2e262bf7136eca4d3638163305429c78';
  double latitude = 0;
  double longitude = 0;
  String city = "London";

  Future<mainweather.Root> getRootInfo() async {
    await getCurrentLocation();
    Response response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey'));
    if (response.statusCode == 200) {
      var data = response.body;

      var decodedJsonData = jsonDecode(data);
      return mainweather.Root.fromJson(decodedJsonData);
    } else {
      throw Exception("An error has occured: ${response.statusCode}");
    }
  }

  Future<List<mainweather.Weather>> getWeatherInfo() async {
    await getCurrentLocation();
    Response response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey'));
    if (response.statusCode == 200) {
      var data = response.body;
      var decodedJsonData = jsonDecode(data);
      List<dynamic> rawList = decodedJsonData['weather'];
      List<mainweather.Weather> weatherList = [];
      for (var element in rawList) {
        var content = mainweather.Weather.fromJson(element);
        weatherList.add(content);
      }
      return weatherList;
    } else {
      throw Exception("An error has occured: ${response.statusCode}");
    }
  }

  getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission locationPermission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    try {
      if (!serviceEnabled) {
        return Future.error('Acces denied');
      }
      locationPermission = await Geolocator.checkPermission();
      if (locationPermission == LocationPermission.denied) {
        locationPermission = await Geolocator.requestPermission();
        if (locationPermission == LocationPermission.denied) {
          return Future.error("Location is denied");
        }
      }
      if (locationPermission == LocationPermission.deniedForever) {
        return Future.error("Location is denied forever, won't ask again");
      }
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      rethrow;
    }
  }

  Future<mainweather.Main> getCurrentWeatherData() async {
    await getCurrentLocation();
    await getHourlyData();
    Response response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey'));
    if (response.statusCode == 200) {
      var data = response.body;
      var decodedJsonData = jsonDecode(data)['main'];
      return mainweather.Main.fromJson(decodedJsonData);
    } else {
      throw Exception(
          'An error has ocurred! Error code ${response.statusCode}');
    }
  }

  Future<List<hourly.ListElement>> getHourlyData() async {
    await getCurrentLocation();
    Response response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/forecast?lat=$latitude&lon=$longitude&appid=$apiKey'));
    if (response.statusCode == 200) {
      var data = response.body;
      var decodedJsonData = jsonDecode(data);
      List<dynamic> rawHourlyList = decodedJsonData['list'];
      List<hourly.ListElement> hourlyList = [];
      for (var element in rawHourlyList) {
        var content = hourly.ListElement.fromJson(element);
        hourlyList.add(content);
      }
      return hourlyList;
    } else {
      throw Exception(
          'An error has ocurred! Error code ${response.statusCode}');
    }
  }

  Future<pollution.Main> getPolutionData() async {
    await getCurrentLocation();
    Response response = await http.get(Uri.parse(
        'http://api.openweathermap.org/data/2.5/air_pollution?lat=$latitude&lon=$longitude&appid=$apiKey'));
    if (response.statusCode == 200) {
      var data = response.body;
      var decodedJsonData = jsonDecode(data)['list'][0]['main'];
      print(decodedJsonData);
      return pollution.Main.fromJson(decodedJsonData);
    } else {
      throw Exception(
          'An error has occured! Error code ${response.statusCode}');
    }
  }
}
//"{"cod":401, "message": "Please note that using One Call 3.0 requires a separate subscription to the One Call by Call plan. Learn…"