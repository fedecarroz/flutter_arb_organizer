import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_arb_organizer/app.dart';
import 'package:flutter_arb_organizer/logic.dart';

void main() {
  BlocOverrides.runZoned(
    () => runApp(const App()),
    blocObserver: DebugBloc(),
  );

  doWhenWindowReady(() {
    appWindow.title = 'Flutter ARB Organizer';
    appWindow.minSize = const Size(1280, 720);
    appWindow.show();
  });
}
