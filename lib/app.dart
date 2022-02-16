import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_arb_organizer/helper/interface.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:responsive_framework/responsive_framework.dart';

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
            color: Colors.blue,
          ),
          child: DropTarget(
            onDragDone: (details) {
              final files = details.files;
              print(files);
            },
            child: Column(
              children: <Widget>[
                Material(
                  color: Colors.transparent,
                  child: WindowTitleBarBox(
                    child: Row(
                      children: [
                        Expanded(
                          child: MoveWindow(
                            child: Row(
                              children: const [
                                SizedBox(width: 5),
                                Icon(
                                  Icons.flutter_dash,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const WindowButtons(),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: child!,
                ),
              ],
            ),
          ),
        );
      },
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      onGenerateRoute: _appRouter.onGenerateRoute,
      supportedLocales: AppLocalizations.supportedLocales,
          child: Column(
            children: <Widget>[
              const _TitleBar(),
              Expanded(
                child: ResponsiveWrapper.builder(
                  child,
                  breakpointsLandscape: <ResponsiveBreakpoint>[
                    const ResponsiveBreakpoint.resize(
                      1080,
                      name: 'DESKTOP_LANDSCAPE',
                      scaleFactor: 1.8,
                    ),
                  ],
                ),
              ),
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
                    padding: EdgeInsets.only(left: 5, top: 5),
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
