import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';

import 'package:flutter_arb_organizer/app.dart';

void main() {
  runApp(const App());

  doWhenWindowReady(() {
    appWindow.title = 'Flutter ARB Organizer';
    appWindow.minSize = const Size(1280, 720);
    appWindow.maximize();
    appWindow.show();
  });
}
