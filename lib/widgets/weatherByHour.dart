import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:klimatzie/models/hourly.dart';
import 'package:klimatzie/services/weather_api.dart';
import 'package:weather_icons/weather_icons.dart';

class ByHour extends StatefulWidget {
  bool? isSwitchedOn;
  ByHour({super.key, this.isSwitchedOn});

  @override
  State<ByHour> createState() => _ByHourState();
}

class _ByHourState extends State<ByHour> {
  WeatherApi weatherApi = WeatherApi();
  List<ListElement> _hourlyList = [];
  Future<void> fetchHourly() async {
    List<ListElement> hourlyList = await weatherApi.getHourlyData();
    setState(() {
      _hourlyList = hourlyList;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchHourly();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.35,
      width: MediaQuery.of(context).size.width,
      child: Stack(children: [
        ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
              ),
              margin: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: ListView.builder(
                  itemCount: _hourlyList.length,
                  itemBuilder: ((context, index) {
                    int milis = _hourlyList[index].dt! * 1000;
                    double fa = _hourlyList[index].main?.temp! ?? 0.0;
                    String hourlyTemperature() {
                      if (widget.isSwitchedOn == true) {
                        return '${fa.toString().substring(0, 5)}°K';
                      } else {
                        return '${(fa - 273).toString().substring(0, 4)}°C';
                      }
                    }

                    BoxedIcon weatherIcons() {
                      var id = _hourlyList[index].weather![0].id!;
                      if (id <= 232) {
                        return const BoxedIcon(
                          WeatherIcons.thunderstorm,
                          color: Colors.white,
                        );
                      } else if (id >= 299 && id <= 322) {
                        return const BoxedIcon(
                          WeatherIcons.raindrop,
                          color: Colors.white,
                        );
                      } else if (id >= 500 && id <= 531) {
                        return const BoxedIcon(
                          WeatherIcons.raindrops,
                          color: Colors.white,
                        );
                      } else if (id >= 600 && id <= 622) {
                        return const BoxedIcon(
                          WeatherIcons.snow,
                          color: Colors.white,
                        );
                      } else if (id >= 700 && id <= 781) {
                        return const BoxedIcon(
                          WeatherIcons.fog,
                          color: Colors.white,
                        );
                      } else if (id == 800) {
                        return const BoxedIcon(
                          WeatherIcons.night_clear,
                          color: Colors.white,
                        );
                      } else if (id >= 801 && id <= 804) {
                        return const BoxedIcon(
                          WeatherIcons.cloud,
                          color: Colors.white,
                        );
                      } else {
                        return const BoxedIcon(
                          WeatherIcons.tsunami,
                          color: Colors.white,
                        );
                      }
                    }

                    var dt = DateTime.fromMillisecondsSinceEpoch(milis);
                    var dtFormatted = DateFormat('yyyy/MM/dd').format(dt);
                    var hourFormatter = DateFormat('hh:mm').format(dt);
                    return Container(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20.0, bottom: 20.0),
                      height: 100,
                      child: ListTile(
                        leading: weatherIcons(),
                        style: ListTileStyle.list,
                        title: Text(dtFormatted.toString()),
                        subtitle: Text(hourlyTemperature().toString()),
                        trailing: Text(hourFormatter.toString()),
                      ),
                    );
                  })),
            ),
          ),
        ),
      ]),
    );
  }
}
