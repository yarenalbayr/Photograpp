import 'package:flutter/material.dart';

extension ThemeContext on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;
}

ThemeData get lightTheme => ThemeData(
      brightness: Brightness.light,
      fontFamily: 'Lato',
      backgroundColor: const Color.fromRGBO(245, 245, 245, 1),
      scaffoldBackgroundColor: const Color.fromRGBO(245, 245, 245, 1),
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: Color.fromRGBO(223, 148, 89, 1),
        onPrimary: Color.fromRGBO(223, 148, 89, 1),
        secondary: Color.fromRGBO(61, 60, 60, 1),
        onSecondary: Color.fromRGBO(61, 60, 60, 1),
        error: Color(0XFFE55752),
        onError: Color(0XFFE55752),
        background: Color.fromRGBO(245, 245, 245, 1),
        onBackground: Color.fromRGBO(245, 245, 245, 1),
        surface: Color.fromRGBO(102, 102, 102, 1),
        onSurface: Color.fromRGBO(102, 102, 102, 1),
      ),
      textTheme: const TextTheme(
        headline1: TextStyle(
          fontFamily: 'Lato',
          fontSize: 24,
          color: Color.fromRGBO(61, 60, 60, 1),
        ),
        headline2: TextStyle(
          fontFamily: 'Lato',
          fontSize: 16,
          color: Color.fromRGBO(61, 60, 60, 1),
        ),
        headline3: TextStyle(
          fontFamily: 'Lato',
          fontSize: 12,
          color: Color.fromRGBO(61, 60, 60, 1),
        ),
      ),
    );
