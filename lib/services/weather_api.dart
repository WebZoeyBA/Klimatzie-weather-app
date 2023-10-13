import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:klimatzie/models/mainweather.dart';
import 'package:geocoding/geocoding.dart';

class WeatherApi {
  String apiKey = '8d2c65d9e536a8efe0bcadcc9453209e';
  double latitude = 0;
  double longitude = 0;
  String city = "London";

  Future<Root> getRootInfo() async {
    await getCurrentLocation();
    Response response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey'));
    if (response.statusCode == 200) {
      var data = response.body;
      print(data);
      var decodedJsonData = jsonDecode(data);
      return Root.fromJson(decodedJsonData);
    } else {
      throw Exception("An error has occured: ${response.statusCode}");
    }
  }

  Future<List<Weather>> getWeatherInfo() async {
    await getCurrentLocation();
    Response response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey'));
    if (response.statusCode == 200) {
      var data = response.body;
      var decodedJsonData = jsonDecode(data);
      List<dynamic> rawList = decodedJsonData['weather'];
      List<Weather> weatherList = [];
      for (var element in rawList) {
        var content = Weather.fromJson(element);
        weatherList.add(content);
      }
      return weatherList;
    } else {
      throw Exception("An error has occured: ${response.statusCode}");
    }
  }

// From coordinates
  Future<void> getAdress() async {
    await getCurrentLocation();
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude, longitude);
    print(placemarks);
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

  Future<Main> getCurrentWeatherData() async {
    await getCurrentLocation();
    Response response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey'));
    if (response.statusCode == 200) {
      var data = response.body;
      var decodedJsonData = jsonDecode(data)['main'];
      return Main.fromJson(decodedJsonData);
    } else {
      throw Exception(
          'An error has ocurred! Error code ${response.statusCode}');
    }
  }
}
//"{"cod":401, "message": "Please note that using One Call 3.0 requires a separate subscription to the One Call by Call plan. Learn…"