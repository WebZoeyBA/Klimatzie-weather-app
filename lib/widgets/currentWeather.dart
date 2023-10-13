import 'package:flutter/material.dart';

class CurrentWeather extends StatefulWidget {
  final String? cityName;
  final String? temperature;
  final String description;
  CurrentWeather({this.cityName, this.temperature, required this.description});

  @override
  State<CurrentWeather> createState() => _CurrentWeatherState();
}

class _CurrentWeatherState extends State<CurrentWeather> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width * 0.7,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            widget.cityName!,
            style: Theme.of(context).textTheme.displayMedium,
          ),
          Text(
            widget.temperature!,
            style: Theme.of(context).textTheme.displayLarge,
          ),
          Center(
            child: Text(
              widget.description,
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ),
        ],
      ),
    );
  }
}
