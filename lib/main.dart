
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';

import 'package:flutter_arb_organizer/app.dart';

void main() {
  runApp(const App());

  doWhenWindowReady(() {
    const initialSize = Size(1280, 720);
    appWindow.minSize = initialSize;
    //appWindow.size = initialSize;
    //appWindow.alignment = Alignment.center;
    appWindow.title = 'Flutter ARB Organizer';
    appWindow.show();
  });
}
