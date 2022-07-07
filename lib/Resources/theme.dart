import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextTheme textTheme = GoogleFonts.poppinsTextTheme();

var lightThemeData =
    ThemeData(colorScheme: lightColorScheme, textTheme: textTheme);

var darkThemeData =
    ThemeData(colorScheme: darkColorScheme, textTheme: textTheme);

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFFEEAFF0),
  onPrimary: Color.fromARGB(255, 22, 0, 83),
  primaryContainer: Color(0xFFEEAFF0),
  onPrimaryContainer: Color.fromARGB(255, 16, 0, 61),
  //secondary: Colors.cyan.withOpacity(.5), //Color.fromARGB(255, 235, 255, 87),
  secondary: Color(0xFF77E2D7),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color.fromARGB(255, 116, 227, 216),
  onSecondaryContainer: Color(0xFF231B00),
  tertiary: Color(0xFFB90065),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFFFFD9E3),
  onTertiaryContainer: Color(0xFF3E001E),
  error: Color(0xFFBA1A1A),
  errorContainer: Color(0xFFFFDAD6),
  onError: Color(0xFFFFFFFF),
  onErrorContainer: Color(0xFF410002),
  background: Color.fromARGB(255, 0, 0, 0),
  onBackground: Color.fromARGB(255, 255, 255, 255),
  surface: Color(0xFFFFFCF4),
  onSurface: Color(0xFF1B1C17),
  surfaceVariant: Color(0xFFE3E3D3),
  onSurfaceVariant: Color(0xFF46483C),
  outline: Color(0xFF77786A),
  onInverseSurface: Color(0xFFF3F1E8),
  inverseSurface: Color(0xFF30312B),
  inversePrimary: Color(0xFFBCD063),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF556500),
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFFBCD063),
  onPrimary: Color(0xFF2B3400),
  primaryContainer: Color(0xFF3F4C00),
  onPrimaryContainer: Color(0xFFD7ED7C),
  secondary: Color(0xFFE8C342),
  onSecondary: Color(0xFF3C2F00),
  secondaryContainer: Color(0xFF564500),
  onSecondaryContainer: Color(0xFFFFE07F),
  tertiary: Color(0xFFFFB0C9),
  onTertiary: Color(0xFF650034),
  tertiaryContainer: Color(0xFF8E004C),
  onTertiaryContainer: Color(0xFFFFD9E3),
  error: Color(0xFFFFB4AB),
  errorContainer: Color(0xFF93000A),
  onError: Color(0xFF690005),
  onErrorContainer: Color(0xFFFFDAD6),
  background: Color(0xFF1B1C17),
  onBackground: Color(0xFFE5E2DA),
  surface: Color(0xFF1B1C17),
  onSurface: Color(0xFFE5E2DA),
  surfaceVariant: Color(0xFF46483C),
  onSurfaceVariant: Color(0xFFC7C8B7),
  outline: Color(0xFF919283),
  onInverseSurface: Color(0xFF1B1C17),
  inverseSurface: Color(0xFFE5E2DA),
  inversePrimary: Color(0xFF556500),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFFBCD063),
);
