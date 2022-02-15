import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appLocal = AppLocalizations.of(context)!;

    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Text(
            'BONFRY',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 40,
            ),
          ),
        ),
      ),
    );
  }
}
