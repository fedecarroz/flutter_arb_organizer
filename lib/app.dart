import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter_arb_organizer/helper/interface.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  late AppRouter _appRouter;

  @override
  void initState() {
    super.initState();
    _appRouter = AppRouter();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) => child!,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      onGenerateRoute: _appRouter.onGenerateRoute,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
