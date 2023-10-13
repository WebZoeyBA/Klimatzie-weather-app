import 'package:flutter/material.dart';

final ThemeData amazonThemeData = ThemeData(
  primaryColor: Colors.white,
  colorScheme: const ColorScheme(
    primary: Colors.white,
    primaryContainer: Color(0xFF0A0F16), // A darker variant of primary
    secondary: Color(0xFFFF9900), // This replaces accentColor
    secondaryContainer: Color(0xFFD87F00), // A darker variant of secondary
    surface: Colors.white,
    background: Color(0xFFF3F3F3),
    error: Colors.red,
    onPrimary: Colors.white,
    onSecondary: Colors.black,
    onSurface: Colors.black,
    onBackground: Colors.black,
    onError: Colors.white,
    brightness: Brightness.light,
  ), // Amazon's signature orange
  scaffoldBackgroundColor: const Color(0xFFF3F3F3), // Light gray background
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF131A22),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 50.0,
      fontWeight: FontWeight.w100,
    ),
    toolbarTextStyle: TextStyle(
      color: Colors.white,
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: const Color(0xFFFF9900),
    textTheme: ButtonTextTheme.primary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4.0),
    ),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
        color: Colors.white, fontSize: 80, fontWeight: FontWeight.w100),
    displayMedium: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w100,
      fontSize: 50,
    ),
    displaySmall: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w100,
      fontSize: 30,
    ),
    bodyLarge: TextStyle(
      color: Colors.white,
    ),
    bodyMedium: TextStyle(
      color: Colors.white, // Slightly lighter text for secondary content
    ),
  ),
  iconTheme: const IconThemeData(
    color: Color(0xFF555555),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      side: const BorderSide(
        color: Colors.orange,
        width: 1.0,
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(Colors.orange),
    ),
  ),
  iconButtonTheme: IconButtonThemeData(
    style: ButtonStyle(
      shape: MaterialStateProperty.all<OutlinedBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: const BorderSide(color: Colors.orange),
        ),
      ),
      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: const TextStyle(color: Colors.white),
    hintStyle: const TextStyle(color: Colors.white),
    fillColor: Colors.white,
    filled: false,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4.0),
      borderSide: const BorderSide(
        width: 1.0,
        color: Color(0xFFAAAAAA), // Gray border for input fields
      ),
    ),
    enabledBorder:
        const OutlineInputBorder(borderSide: BorderSide(color: Colors.orange)),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4.0),
      borderSide: const BorderSide(
        color: Colors.white, // Orange border when input is focused
      ),
    ),
  ),
  checkboxTheme: CheckboxThemeData(
    checkColor: MaterialStateColor.resolveWith((states) {
      if (states.contains(MaterialState.disabled)) {
        return Colors.orange; // Set the desired check color for disabled state
      }

      return Colors.orange; // Use default check color for other states
    }),
    overlayColor: MaterialStateColor.resolveWith((states) {
      if (states.contains(MaterialState.disabled)) {
        return Colors.white.withOpacity(
            0.0); // Set the desired overlay color for disabled state
      }
      return Colors.white; // Use default overlay color for other states
    }),
    fillColor: MaterialStateColor.resolveWith((states) {
      if (states.contains(MaterialState.disabled)) {
        return Colors.white.withOpacity(
            0.2); // Set the desired overlay color for disabled state
      }
      return Colors.white;
    }),
  ),
);
