import 'package:flutter/material.dart';
import 'package:klimatzie/screens/wall_page.dart';
import 'package:klimatzie/theme/themedata.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: amazonThemeData,
      home: WallPage(),
    );
  }
}
