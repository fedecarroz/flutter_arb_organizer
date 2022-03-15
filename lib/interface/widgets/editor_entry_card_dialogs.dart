import 'package:flutter/material.dart';
import 'package:flutter_arb_organizer/data/models.dart';

import 'package:flutter_arb_organizer/interface.dart';
import 'package:flutter_arb_organizer/logic.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> showRenameDialog(BuildContext context, ArbEntry arbEntry) {
  return showDialog<void>(
    context: context,
    builder: (_) => BlocProvider.value(
      value: context.read<ArbEditorBloc>(),
      child: _RenameDialog(arbEntry: arbEntry),
    ),
  );
}

class _RenameDialog extends StatelessWidget {
  final renameController = TextEditingController();
  final ArbEntry arbEntry;

  _RenameDialog({
    Key? key,
    required this.arbEntry,
  }) : super(key: key) {
    renameController.text = arbEntry.key;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MainCard(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CardHeader(
              title: 'Rinomina entry',
              onBack: () => Navigator.of(context).pop(),
            ),
            const SizedBox(height: 20),
            Row(
              children: <Widget>[
                Text(
                  'Chiave entry:',
                  style: TextStyle(
                    color: Colors.blue[800],
                    fontSize: 18,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Inserisci la chiave della entry',
                    ),
                    controller: renameController,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            PrimaryButton(
              label: 'Rinomina',
              onPressed: () {
                context.read<ArbEditorBloc>().add(
                      ArbEditorEntryUpdated(
                        arbEntry,
                        newKey: renameController.text,
                      ),
                    );
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> showSetGroupDialog(BuildContext context, ArbEntry arbEntry) {
  return showDialog<void>(
    context: context,
    builder: (context) => _SetGroupDialog(arbEntry: arbEntry),
  );
}

class _SetGroupDialog extends StatelessWidget {
  final ArbEntry arbEntry;

  const _SetGroupDialog({
    Key? key,
    required this.arbEntry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MainCard(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CardHeader(
              title: 'Imposta gruppo',
              onBack: () => Navigator.of(context).pop(),
            ),
            const SizedBox(height: 20),
            //TODO: interfaccia dai filtri con radio
            const SizedBox(height: 20),
            PrimaryButton(
              label: 'Imposta',
              onPressed: () {}, //TODO: collega la logica
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> showDeleteEntryDialog(BuildContext context, ArbEntry arbEntry) {
  return showDialog<void>(
    context: context,
    builder: (context) => _DeleteEntryDialog(arbEntry: arbEntry),
  );
}

class _DeleteEntryDialog extends StatelessWidget {
  final deleteController = TextEditingController();
  final ArbEntry arbEntry;

  _DeleteEntryDialog({
    Key? key,
    required this.arbEntry,
  }) : super(key: key) {
    deleteController.text = arbEntry.key;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MainCard(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CardHeader(
              title: 'Elimina entry',
              onBack: () => Navigator.of(context).pop(),
            ),
            const SizedBox(height: 20),
            RichText(
              text: const TextSpan(
                text: 'Sei sicuro di voler rimuovere la entry selezionata? '
                    'Il processo è ',
                style: TextStyle(
                  color: Colors.black,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: 'irreversibile',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(text: '.')
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: <Widget>[
                Expanded(
                  child: SecondaryButton(
                    label: 'Annulla',
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: PrimaryButton(
                    label: 'Conferma',
                    onPressed: () {
                      //TODO: implementa logica
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
