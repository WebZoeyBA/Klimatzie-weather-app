import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TempUnit extends StatefulWidget {
  bool isSwitched;
  Function(bool) onToggle;
  TempUnit({super.key, required this.isSwitched, required this.onToggle});

  @override
  State<TempUnit> createState() => _TempUnitState();
}

class _TempUnitState extends State<TempUnit> {
  void switchUnit(value) {
    widget.onToggle(value);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("°C"),
          Switch(value: widget.isSwitched, onChanged: switchUnit),
          const Text("°K")
        ],
      ),
    );
  }
}
