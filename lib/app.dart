import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:desktop_drop/desktop_drop.dart';
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
    );
  }
}
