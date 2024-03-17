import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData theme() {
  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: const Color.fromRGBO(65, 102, 245, 1),
    fontFamily: 'Poppins',
    appBarTheme: const AppBarTheme(),
  );
}

AppBarTheme appBarTheme() {
  setStatusBarColor();
  return AppBarTheme(
    color: Colors.white,
    elevation: 0,
    iconTheme: const IconThemeData(color: Colors.black),
    backgroundColor: Colors.white,
  );
}

void setStatusBarColor() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.white, // Color for status bar
      statusBarBrightness: Brightness.light, // Brightness of status bar
      statusBarIconBrightness:
          Brightness.dark, // Brightness of icons in status bar
    ),
  );
}
