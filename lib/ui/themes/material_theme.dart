import 'package:flutter/material.dart';

import 'package:flutter_arb_organizer/ui.dart';

class MaterialTheme extends StatelessWidget {
  final Widget child;

  const MaterialTheme({
    Key? key,
    required this.child,
  }) : super(key: key);

  static const _fontFamily = 'Lota';
  static const defaultTextStyle = TextStyle(
    fontFamily: _fontFamily,
    color: ColorPalette.white,
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );
  static const defaultTextTheme = TextTheme(
    bodyLarge: defaultTextStyle,
    bodyMedium: defaultTextStyle,
    bodySmall: defaultTextStyle,
    labelLarge: defaultTextStyle,
    labelMedium: defaultTextStyle,
    labelSmall: defaultTextStyle,
    displayLarge: defaultTextStyle,
    displayMedium: defaultTextStyle,
    displaySmall: defaultTextStyle,
    headlineLarge: defaultTextStyle,
    headlineMedium: defaultTextStyle,
    headlineSmall: defaultTextStyle,
    titleLarge: defaultTextStyle,
    titleMedium: defaultTextStyle,
    titleSmall: defaultTextStyle,
  );

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        fontFamily: _fontFamily,
        primaryTextTheme: defaultTextTheme,
        textTheme: defaultTextTheme,
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            foregroundColor: WidgetStateProperty.all(ColorPalette.white),
            textStyle: WidgetStateProperty.all(defaultTextStyle),
          ),
        ),
      ),
      child: child,
    );
  }
}
