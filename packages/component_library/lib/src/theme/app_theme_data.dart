import 'package:flutter/material.dart';

import 'dark_color_scheme.dart';
import 'light_color_scheme.dart';
import 'text_theme.dart';

final class AppThemeData {
  static ThemeData light(BuildContext context) {
    return _theme(lightColorScheme, context);
  }

  static ThemeData dark(BuildContext context) {
    return _theme(darkColorScheme, context);
  }

  static ThemeData _theme(ColorScheme colorScheme, BuildContext context) {
    final textTheme = createTextTheme(context);

    return ThemeData(
      useMaterial3: true,
      brightness: colorScheme.brightness,
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      colorScheme: colorScheme,
      textTheme: textTheme.apply(
        bodyColor: colorScheme.onSurface,
        displayColor: colorScheme.onSurface,
      ),
      scaffoldBackgroundColor: colorScheme.surface,
      canvasColor: colorScheme.surface,
    );
  }
}
