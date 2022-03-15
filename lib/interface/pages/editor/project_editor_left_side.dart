import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter_arb_organizer/interface.dart';
import 'package:flutter_arb_organizer/logic.dart';

class LeftSide extends StatelessWidget {
  const LeftSide({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.blue[700],
        width: double.maxFinite,
        padding: EdgeInsets.only(
          top: appWindow.titleBarHeight + 20,
        ),
        child: BlocBuilder<ArbEditorBloc, ArbEditorState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _ProjectName(state.document.projectName),
                const SizedBox(height: 20),
                const Expanded(child: _LeftMainMenu()),
              ],
            );
          },
        ));
  }
}

class _ProjectName extends StatelessWidget {
  final String projectName;

  const _ProjectName(this.projectName, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Text(
        projectName,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 24,
        ),
      ),
    );
  }
}

class _LeftMainMenu extends StatelessWidget {
  const _LeftMainMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appLocal = AppLocalizations.of(context)!;

    return BlocBuilder<ArbEditorBloc, ArbEditorState>(
      builder: (context, state) {
        final arbDoc = state.document;

        return Column(
          children: <Widget>[
            EditorButton(
              label: 'Totale stringhe localizzate: ${arbDoc.labels.length}',
              onTap: null,
            ),
            EditorButton(
              label: 'Gruppi creati: ${arbDoc.groups.length}',
              onTap: null,
            ),
            EditorButton(
              label: 'Lingue supportate: ${arbDoc.languages.length}',
              onTap: null,
            ),
            const Expanded(child: SizedBox()),
            EditorButton(
              centerText: true,
              specialColor: true,
              label: 'Esporta',
              onTap: () {
                final doc = context.read<ArbEditorBloc>().state.document;
                context.read<FileIOBloc>().add(FileIOArbsSaved(doc));
              },
            ),
          ],
        );
      },
    );
  }
}
