import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:klimatzie/models/mainweather.dart';
import 'package:klimatzie/services/weather_api.dart';
import 'package:klimatzie/theme/themedata.dart';
import 'package:klimatzie/widgets/currentWeather.dart';
import 'package:klimatzie/widgets/tempUnit.dart';
import 'package:klimatzie/widgets/weatherByHour.dart';
import 'package:klimatzie/models/pollution.dart' as pollution;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Main? _main;
  Root? _root;
  pollution.Main? _pollutionMain;

  List<Weather>? _weather;
  WeatherApi weatherapi = WeatherApi();

  bool celsius = true;

  double temperature = 0.0;
  String err = "Error retrieving info";

  Future<void> fetchAqi() async {
    var pollution = await weatherapi.getPolutionData();
    setState(() {
      _pollutionMain = pollution;
    });
  }

  Future<void> fetchMain() async {
    var main = await weatherapi.getCurrentWeatherData();
    setState(() {
      _main = main;
    });
  }

  Future<void> fetchWeather() async {
    List<Weather> weatherList = await weatherapi.getWeatherInfo();
    setState(() {
      _weather = weatherList;
    });
  }

  Future<void> fetchRootInfo() async {
    var root = await weatherapi.getRootInfo();
    setState(() {
      _root = root;
    });
  }

  AssetImage setBgImage() {
    if (_root?.weather?[0]?.description == "Rain") {
      return const AssetImage('images/rainy-bg.jpeg');
    } else if (_root?.weather?[0]?.description == "Snow") {
      return const AssetImage('images/snow.jpeg');
    } else if (_root?.weather?[0]?.description == "Clear") {
      return const AssetImage('images/sunny-no-clouds.jpeg');
    } else {
      return const AssetImage('images/sunny-no-clouds.jpeg');
    }
  }

  String switchTemperature() {
    if (celsius) {
      return '${(_main?.temp).toString().substring(0, 3)}°K';
    } else {
      return '${(_main?.temp - 273).toString().substring(0, 2)}°C';
    }
  }

  String switchFeelsLike() {
    if (celsius) {
      return 'But it feels like ${(_main?.feelslike).toString().substring(0, 5)}°K';
    } else {
      return 'But it feels like ${(_main?.feelslike - 273).toString().substring(0, 4)}°C';
    }
  }

  String airQuality() {
    String aqi = "Air quality:";
    if (_pollutionMain!.aqi == 1) {
      return "$aqi Good ";
    } else if (_pollutionMain!.aqi == 2) {
      return "$aqi Fair ";
    } else if (_pollutionMain!.aqi == 3) {
      return "$aqi Moderate ";
    } else if (_pollutionMain!.aqi == 4) {
      return "$aqi Poor";
    } else if (_pollutionMain!.aqi == 5) {
      return "$aqi Very Poor";
    } else {
      return err;
    }
  }

  @override
  void initState() {
    super.initState();
    fetchMain();
    fetchRootInfo();
    fetchWeather();
    fetchAqi();
    weatherapi.getHourlyData();
    weatherapi.getPolutionData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: setBgImage(), fit: BoxFit.cover),
        ),
        child: _main == null
            ? const Center(child: CircularProgressIndicator())
            : Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                    TempUnit(
                      isSwitched: celsius,
                      onToggle: (value) {
                        setState(() {
                          celsius = value;
                        });
                      },
                    ),
                    CurrentWeather(
                        cityName: _root?.name.toString() ?? err,
                        temperature: switchTemperature(),
                        description: _weather?[0].description.toString() ?? err,
                        feelsLike: switchFeelsLike()),
                    Text(
                      airQuality(),
                      style: amazonThemeData.textTheme.bodySmall,
                    ),
                    ClipRRect(
                      child: Column(
                        children: [
                          BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 15.0),
                              child: Text(
                                "5 Day / 3 Hours forecast:",
                                style: amazonThemeData.textTheme.bodyLarge,
                              ),
                            ),
                          ),
                          ByHour(
                            isSwitchedOn: celsius,
                          ),
                        ],
                      ),
                    ),
                  ]),
      ),
    );
  }
}
