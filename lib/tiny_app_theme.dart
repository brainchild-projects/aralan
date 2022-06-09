import 'package:flutter/material.dart';

import 'colors.dart';

class TinyAppTheme {
  static const _lightFillColor = Colors.black;
  static const _darkFillColor = Colors.white;

  static final Color _lightFocusColor = Colors.black.withOpacity(0.12);
  static final Color _darkFocusColor = Colors.white.withOpacity(0.12);

  static ThemeData lightThemeData =
      themeData(lightColorScheme, _lightFocusColor);
  static ThemeData darkThemeData = themeData(darkColorScheme, _darkFocusColor);

  static ThemeData themeData(ColorScheme colorScheme, Color focusColor) {
    return ThemeData(
      colorScheme: colorScheme,
      textTheme: _textTheme.apply(
        bodyColor: colorScheme.onBackground,
        displayColor: colorScheme.onBackground,
      ),
      // Matches manifest.json colors and background color.
      primaryColor: colorScheme.primary,
      backgroundColor: colorScheme.background,
      appBarTheme: AppBarTheme(
        // textTheme: _textTheme.apply(bodyColor: colorScheme.onBackground),
        // toolbarTextStyle: ,
        color: colorScheme.background,
        elevation: 0,
        iconTheme: IconThemeData(color: colorScheme.primary),
      ),
      iconTheme: IconThemeData(color: colorScheme.onPrimary),
      canvasColor: colorScheme.background,
      scaffoldBackgroundColor: colorScheme.background,
      highlightColor: Colors.transparent,
      // accentColor: colorScheme.primary,
      focusColor: focusColor,
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Color.alphaBlend(
          _lightFillColor.withOpacity(0.80),
          _darkFillColor,
        ),
        contentTextStyle: _textTheme.subtitle1!.apply(color: _darkFillColor),
      ),
    );
  }

  static const _textColorLight = Color(0xFF333333);
  static const _textColorDark = Color(0xFFF2F2F2);

  static const ColorScheme lightColorScheme = ColorScheme(
    primary: kBlue,
    primaryContainer: Color(0xFF2D9CDB),
    secondary: Color(0xFFF2994A),
    secondaryContainer: Color(0xFFF2C94C),
    background: Colors.white,
    surface: Colors.white,
    error: _lightFillColor,
    onBackground: _textColorLight,
    onError: _textColorLight,
    onPrimary: _textColorDark,
    onSecondary: _textColorDark,
    onSurface: _textColorLight,
    brightness: Brightness.light,
  );

  static const ColorScheme darkColorScheme = ColorScheme(
    primary: Color(0xFF56CCF2),
    primaryContainer: Color(0xFF1CDEC9),
    secondary: Color(0xFFF8D670),
    secondaryContainer: Color(0xFFFFFA89),
    background: _darkFillColor,
    surface: _darkFillColor,
    error: _darkFillColor,
    onBackground: _textColorDark,
    onError: _textColorDark,
    onPrimary: _textColorDark,
    onSecondary: _textColorDark,
    onSurface: _textColorDark,
    brightness: Brightness.dark,
  );

  static const _regular = FontWeight.w400;
  static const _bold = FontWeight.w700;

  static const _fontFamily = 'Andika New Basic';

  static textStyle({
    FontWeight fontWeight = _regular,
    double fontSize = 16.0,
  }) =>
      TextStyle(
        fontFamily: _fontFamily,
        fontWeight: fontWeight,
        fontSize: fontSize,
      );

  static final TextTheme _textTheme = TextTheme(
    caption: textStyle(fontWeight: _regular, fontSize: 16.0),
    bodyText2: textStyle(fontWeight: _regular, fontSize: 16.0),
    bodyText1: textStyle(fontWeight: _regular, fontSize: 14.0),
    headline1: textStyle(fontWeight: _regular, fontSize: 64.0),
    headline2: textStyle(fontWeight: _regular, fontSize: 48.0),
    headline3: textStyle(fontWeight: _regular, fontSize: 32.0),
    headline4: textStyle(fontWeight: _bold, fontSize: 20.0),
    headline5: textStyle(fontWeight: _regular, fontSize: 16.0),
    headline6: textStyle(fontWeight: _bold, fontSize: 16.0),
    overline: textStyle(fontWeight: _regular, fontSize: 12.0),
    subtitle1: textStyle(fontWeight: _regular, fontSize: 16.0),
    subtitle2: textStyle(fontWeight: _regular, fontSize: 14.0),
    button: textStyle(fontWeight: _regular, fontSize: 14.0),
  );
}
