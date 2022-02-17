import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_arb_organizer/interface.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool goAhead = false;

  @override
  Widget build(BuildContext context) {
    var appLocal = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.blue,
      body: DropTarget(
        onDragDone: (details) {
          final files = details.files;
          print(files);
        },
        child: Center(
          child: _MainCard(
            child: !goAhead
                ? _WelcomeSection(
                    onPressed: () => setState(() {
                      goAhead = true;
                    }),
                  )
                : _ProjectDetails(
                    onPressed: () => setState(() {
                      goAhead = false;
                    }),
                  ),
          ),
        ),
      ),
    );
  }
}

class _MainCard extends StatelessWidget {
  final Widget child;

  const _MainCard({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
          ),
        ],
      ),
      width: 400,
      padding: const EdgeInsets.all(30),
      child: child,
    );
  }
}

class _WelcomeSection extends StatelessWidget {
  final void Function()? onPressed;

  const _WelcomeSection({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          'Flutter ARB Organizer',
          style: TextStyle(
            color: Colors.blue[800],
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            PrimaryButton(
              onPressed: onPressed,
              label: 'Nuovo progetto',
            ),
            PrimaryButton(
              onPressed: () {},
              label: 'Importa file.arb',
            ),
          ],
        ),
      ],
    );
  }
}

class _ProjectDetails extends StatelessWidget {
  final void Function()? onPressed;

  const _ProjectDetails({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                child: const Icon(
                  Icons.arrow_back_rounded,
                ),
                onTap: onPressed,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              'Dettagli progetto',
              style: TextStyle(
                color: Colors.blue[800],
                fontSize: 20,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        TextFormField(
          decoration: const InputDecoration(
            hintText: 'Nome del progetto',
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Expanded(
              child: Text(
                'Lingua principale: it_IT',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            SecondaryButton(
              onPressed: () {},
              label: 'Cambia',
            ),
          ],
        ),
        const SizedBox(height: 5),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {},
            child: const Text(
              'Aggiungi lingua',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Center(
          child: PrimaryButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(projectEditorRoute),
            label: 'Avanti',
          ),
        ),
      ],
    );
  }
}
