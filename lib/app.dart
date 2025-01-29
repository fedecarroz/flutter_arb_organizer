import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_arb_organizer/ui.dart';
import 'package:flutter_arb_organizer/logic.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
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
    return BlocProvider<FileIOBloc>(
      create: (context) => FileIOBloc(),
      child: MaterialTheme(
        child: Material(
          color: Colors.transparent,
          child: MaterialApp(
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
          ),
        ),
      ),
    );
  }
}

class _TitleBar extends StatelessWidget {
  const _TitleBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isMacOS
        ? Container()
        : WindowTitleBarBox(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: MoveWindow(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Platform.isMacOS ? 15 : 5,
                      ),
                      child: Row(
                        mainAxisAlignment: Platform.isMacOS
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        children: const <Widget>[
                          Padding(
                            padding: EdgeInsets.all(3),
                            child: Icon(
                              Icons.text_fields,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 5),
                          Material(
                            color: Colors.transparent,
                            child: Padding(
                              padding: EdgeInsets.only(top: 3),
                              child: Text(
                                'Flutter ARB Organizer',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const WindowButtons(),
              ],
            ),
          );
  }
}
