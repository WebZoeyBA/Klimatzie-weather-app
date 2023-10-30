import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:klimatzie/models/mainweather.dart';
import 'package:klimatzie/screens/homepage.dart';
import 'package:klimatzie/services/weather_api.dart';

class WallPage extends StatefulWidget {
  const WallPage({super.key});

  @override
  State<WallPage> createState() => _WallPageState();
}

class _WallPageState extends State<WallPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation();
  }

  double? latitude;
  double? longitude;
  WeatherApi weatherApi = WeatherApi();

  void getLocation() async {
    await weatherApi.getCurrentLocation();

    latitude = weatherApi.latitude;
    longitude = weatherApi.longitude;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.lightBlue,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () async {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const HomePage()));
                  },
                  icon: const Icon(Icons.power))
            ],
          ),
        ));
  }
}
