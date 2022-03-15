import 'package:flutter/material.dart';
import 'package:flutter_arb_organizer/data.dart';
import 'package:flutter_arb_organizer/interface.dart';
import 'package:flutter_arb_organizer/logic.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    final args = routeSettings.arguments;

    switch (routeSettings.name) {
      case homeRoute:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: <BlocProvider>[
              BlocProvider<HomeBloc>(
                create: (context) => HomeBloc(),
              ),
              BlocProvider<ArbCreateFormBloc>(
                create: (context) => ArbCreateFormBloc(),
              ),
              BlocProvider<ArbImportFormBloc>(
                create: (context) => ArbImportFormBloc(),
              ),
            ],
            child: const HomePage(),
          ),
        );
      case projectEditorRoute:
        final arbDoc = args as ArbDocument;

        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: <BlocProvider>[
              BlocProvider<ArbEditorBloc>(
                create: (context) => ArbEditorBloc(arbDoc),
              ),
              BlocProvider<FilterCubit>(
                create: (context) => FilterCubit(),
              ),
            ],
            child: const ProjectEditorPage(),
          ),
        );
    }

    return null;
  }
}
