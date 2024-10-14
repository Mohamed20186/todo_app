import 'package:flutter/material.dart';

class ApplicationThemeManager {
  static Color primaryLightColor = const Color(0xff5D9CEC);
  static Color primaryDarkColor = const Color(0xff060E1E);

  // Light Theme Definition
  static ThemeData lightThemeData = ThemeData(
    brightness: Brightness.light,
    primaryColor: primaryLightColor,
    scaffoldBackgroundColor: const Color(0xffDFECDB),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.black),
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontFamily: 'Poppins',
      ),
      bodyLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: Colors.black,
        fontFamily: 'Poppins',
      ),
      bodyMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: Colors.black,
        fontFamily: 'Poppins',
      ),
      bodySmall: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w700,
        color: Colors.black,
        fontFamily: 'Poppins',
      ),
      displaySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: Colors.black,
        fontFamily: 'Poppins',
      ),
    ),
    iconTheme: IconThemeData(
      color: primaryLightColor,
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: primaryLightColor,
      textTheme: ButtonTextTheme.primary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryLightColor,
        //  primary: primaryLightColor,
        //  onPrimary: Colors.white,
        textStyle: const TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryLightColor,
      foregroundColor: Colors.white,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: const Color(0xffDFECDB),
      selectedItemColor: primaryLightColor,
      unselectedItemColor: Colors.grey,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedIconTheme: IconThemeData(color: primaryLightColor, size: 35),
      unselectedIconTheme: const IconThemeData(size: 28),
    ),
  );

  // Dark Theme Definition
  static ThemeData darkThemeData = ThemeData(
    brightness: Brightness.dark,
    primaryColor: primaryDarkColor,
    scaffoldBackgroundColor: primaryDarkColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontFamily: 'Poppins',
      ),
      bodyLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: Colors.white,
        fontFamily: 'Poppins',
      ),
      bodyMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: Colors.white,
        fontFamily: 'Poppins',
      ),
      bodySmall: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w700,
        color: Colors.white,
        fontFamily: 'Poppins',
      ),
      displaySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: Colors.white,
        fontFamily: 'Poppins',
      ),
    ),
    iconTheme: IconThemeData(
      color: primaryDarkColor,
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: primaryDarkColor,
      textTheme: ButtonTextTheme.primary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryDarkColor,
        //  primary: primaryDarkColor,
        //  onPrimary: Colors.white,
        textStyle: const TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryDarkColor,
      foregroundColor: Colors.white,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: primaryDarkColor,
      selectedItemColor: primaryDarkColor,
      unselectedItemColor: Colors.grey,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedIconTheme: IconThemeData(color: primaryLightColor, size: 35),
      unselectedIconTheme: const IconThemeData(size: 28),
    ),
  );
}
