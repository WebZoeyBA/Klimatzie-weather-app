import 'package:flutter/material.dart';

class CurrentWeather extends StatefulWidget {
  final String? cityName;
  final String? temperature;
  final String description;
  final String? feelsLike;
  CurrentWeather(
      {this.cityName,
      this.temperature,
      required this.description,
      this.feelsLike});

  @override
  State<CurrentWeather> createState() => _CurrentWeatherState();
}

class _CurrentWeatherState extends State<CurrentWeather> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
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
          Text(
            widget.feelsLike!,
            style: Theme.of(context).textTheme.displaySmall,
          ),
          Text(
            widget.description,
            style: Theme.of(context).textTheme.displaySmall,
          ),
        ],
      ),
    );
  }
}
