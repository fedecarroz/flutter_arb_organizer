import 'package:flutter/material.dart';
import 'package:flutter_arb_organizer/data/repositories/arb_io_repository.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appLocal = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Flutter ARB Organizer',
        ),
      ),
      body: Container(
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              ArbIORepository().readFiles();
            },
            child: const Text('Salva file'),
          ),
        ),
      ),
    );
  }
}
