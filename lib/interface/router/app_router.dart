import 'package:flutter/material.dart';
import 'package:flutter_arb_organizer/interface.dart';
import 'package:flutter_arb_organizer/logic.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    //final args = routeSettings.arguments;

    switch (routeSettings.name) {
      case homeRoute:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(providers: [
            BlocProvider<HomeBloc>(create: (_) => HomeBloc()),
            BlocProvider<ArbCreateFormBloc>(
              create: (_) => ArbCreateFormBloc(),
            ),
            BlocProvider<ArbImportFormBloc>(
              create: (_) => ArbImportFormBloc(),
            ),
          ], child: const HomePage()),
        );
      case projectEditorRoute:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => EditorMenuBloc(),
            child: const ProjectEditorPage(),
          ),
        );
    }

    return null;
  }
}
