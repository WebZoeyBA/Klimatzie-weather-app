import 'package:flutter/material.dart';
import 'package:klimatzie/models/hourly.dart';
import 'package:klimatzie/services/weather_api.dart';

class ByHour extends StatefulWidget {
  const ByHour({super.key});

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
      height: MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
          itemCount: _hourlyList.length,
          itemBuilder: ((context, index) {
            int milis = _hourlyList[index].dt ?? 0;
            var dt = DateTime.fromMillisecondsSinceEpoch(milis);
            return Container(
              height: 100,
              child: ListTile(
                style: ListTileStyle.list,
                title: Text(dt.toString()),
              ),
            );
          })),
    );
  }
}
