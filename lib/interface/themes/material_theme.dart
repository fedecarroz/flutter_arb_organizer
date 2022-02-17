import 'package:flutter/material.dart';

import 'package:flutter_arb_organizer/interface.dart';

class MaterialTheme extends StatelessWidget {
  final Widget child;

  const MaterialTheme({
    Key? key,
    required this.child,
  }) : super(key: key);

  static const String _fontFamily = 'Lota';

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        fontFamily: _fontFamily,
        textTheme: const TextTheme(
          bodyText1: TextStyle(
            fontFamily: _fontFamily,
            color: ColorPalette.white,
          ),
          bodyText2: TextStyle(
            fontFamily: _fontFamily,
            color: ColorPalette.white,
          ),
          button: TextStyle(
            fontFamily: _fontFamily,
            color: ColorPalette.white,
          ),
          caption: TextStyle(
            fontFamily: _fontFamily,
            color: ColorPalette.white,
          ),
          headline1: TextStyle(
            fontFamily: _fontFamily,
            color: ColorPalette.white,
          ),
          headline2: TextStyle(
            fontFamily: _fontFamily,
            color: ColorPalette.white,
          ),
          headline3: TextStyle(
            fontFamily: _fontFamily,
            color: ColorPalette.white,
          ),
          headline4: TextStyle(
            fontFamily: _fontFamily,
            color: ColorPalette.white,
          ),
          headline5: TextStyle(
            fontFamily: _fontFamily,
            color: ColorPalette.white,
          ),
          headline6: TextStyle(
            fontFamily: _fontFamily,
            color: ColorPalette.white,
          ),
          overline: TextStyle(
            fontFamily: _fontFamily,
            color: ColorPalette.white,
          ),
          subtitle1: TextStyle(
            fontFamily: _fontFamily,
            color: ColorPalette.white,
          ),
          subtitle2: TextStyle(
            fontFamily: _fontFamily,
            color: ColorPalette.white,
          ),
        ),
      ),
      child: child,
    );
  }
}