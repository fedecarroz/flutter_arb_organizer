import 'package:flutter/material.dart';

import 'package:flutter_arb_organizer/interface.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    final args = routeSettings.arguments;

    switch (routeSettings.name) {
      case homeRoute:
        return MaterialPageRoute(
          builder: (context) => const HomePage(),
        );
      case projectEditorRoute:
        return MaterialPageRoute(
          builder: (context) => const ProjectEditorPage(),
        );
    }
    
    return null;
  }
}
