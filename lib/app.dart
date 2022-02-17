import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_arb_organizer/helper/interface.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
      builder: (context, child) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          child: Stack(
            children: <Widget>[
              child!,
              const _TitleBar(),
            ],
          ),
        );
      },
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      onGenerateRoute: _appRouter.onGenerateRoute,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}

class _TitleBar extends StatelessWidget {
  const _TitleBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WindowTitleBarBox(
      child: Row(
        children: <Widget>[
          Expanded(
            child: MoveWindow(
              child: Row(
                children: const <Widget>[
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Icon(
                      Icons.flutter_dash,
                      color: Colors.white,
                    ),
                  ),
                  Expanded(child: SizedBox()),
                ],
              ),
            ),
          ),
          const WindowButtons(),
        ],
      ),
    );
  }
}
