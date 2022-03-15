import 'package:flutter/material.dart';
import 'package:flutter_arb_organizer/data.dart';
import 'package:flutter_arb_organizer/interface.dart';
import 'package:flutter_arb_organizer/logic.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> showEditorLanguageListDialog(
  BuildContext context,
  ArbEditorBloc editorBloc,
) {
  return showDialog(
    context: context,
    builder: (context) => BlocProvider<ArbEditorBloc>.value(
      value: editorBloc,
      child: const _LanguageListDialog(),
    ),
  );
}

class _LanguageListDialog extends StatelessWidget {
  const _LanguageListDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final editorBloc = context.watch<ArbEditorBloc>();
    final state = editorBloc.state;

    return Center(
      child: MainCard(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CardHeader(
              title: 'Lingue Supportate',
              onBack: () => Navigator.of(context).pop(),
            ),
            const SizedBox(height: 10),
            state.document.languages.isEmpty
                ? Text(
                    'Nessuna lingua supportata',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  )
                : ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.document.languages.length,
                    itemBuilder: (context, index) {
                      final lang = state.document.languages.elementAt(index);
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            lang,
                            style: const TextStyle(fontSize: 16),
                          ),
                          Row(
                            children: <Widget>[
                              IconButton(
                                onPressed: () => showEditorLanguageEditDialog(
                                  context,
                                  editorBloc,
                                  lang,
                                ),
                                icon: const Icon(Icons.edit),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete_outline),
                                padding: const EdgeInsets.only(left: 0),
                                onPressed: () => showEditorLanguageRemoveDialog(
                                  context,
                                  editorBloc,
                                  lang,
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
            const SizedBox(height: 20),
            PrimaryButton(
              label: 'Nuova lingua',
              onPressed: () {
                final editorBloc = context.read<ArbEditorBloc>();
                showEditorLanguageAddDialog(context, editorBloc);
              },
            )
          ],
        ),
      ),
    );
  }
}

Future<void> showEditorLanguageAddDialog(
  BuildContext context,
  ArbEditorBloc editorBloc,
) {
  return showDialog(
    context: context,
    builder: (context) => BlocProvider<ArbEditorBloc>.value(
      value: editorBloc,
      child: const _LanguageAddDialog(),
    ),
  );
}

class _LanguageAddDialog extends StatelessWidget {
  const _LanguageAddDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final languages = context.watch<ArbEditorBloc>().state.document.languages;

    final languagesAvailable = LanguagesSupported.values.where(
      (l) => !languages.contains(l),
    );

    return Center(
      child: LangSelectCard(
        languages: languagesAvailable.toList(),
        onBackClick: () => Navigator.of(context).pop(),
        title: 'Aggiungi lingua',
        onLanguageClick: (lang) {
          context.read<ArbEditorBloc>().add(ArbEditorLanguageAdded(lang));
          Navigator.pop(context);
        },
      ),
    );
  }
}

Future<void> showEditorLanguageEditDialog(
  BuildContext context,
  ArbEditorBloc editorBloc,
  String currentLang,
) {
  return showDialog<void>(
    context: context,
    builder: (context) => BlocProvider<ArbEditorBloc>.value(
      value: editorBloc,
      child: _LanguageEditDialog(currentLang: currentLang),
    ),
  );
}

class _LanguageEditDialog extends StatelessWidget {
  final String currentLang;

  const _LanguageEditDialog({Key? key, required this.currentLang})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final editoBloc = context.watch<ArbEditorBloc>();
    final state = editoBloc.state;

    final languages = state.document.languages;
    final languagesAvailable = LanguagesSupported.values.where(
      (l) => !languages.contains(l),
    );

    return Center(
      child: LangSelectCard(
        languages: languagesAvailable.toList(),
        onBackClick: () => Navigator.of(context).pop(),
        title: 'Cambia lingua',
        onLanguageClick: (lang) {
          editoBloc.add(
            ArbEditorLanguageUpdated(
              oldLang: currentLang,
              newLang: lang,
            ),
          );
          Navigator.pop(context);
        },
      ),
    );
  }
}

Future<void> showEditorLanguageRemoveDialog(
  BuildContext context,
  ArbEditorBloc editorBloc,
  String currentLang,
) {
  return showDialog<void>(
    context: context,
    builder: (context) => BlocProvider<ArbEditorBloc>.value(
      value: editorBloc,
      child: _LanguageRemoveDialog(currentLang: currentLang),
    ),
  );
}

class _LanguageRemoveDialog extends StatelessWidget {
  final String currentLang;
  const _LanguageRemoveDialog({Key? key, required this.currentLang})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final editoBloc = context.watch<ArbEditorBloc>();

    return Center(
      child: MainCard.dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const CardHeader(
              title: 'Rimuovi lingua',
            ),
            const SizedBox(height: 15),
            RichText(
              text: const TextSpan(
                text: 'Sei sicuro di voler rimuovere la lingua selezionata?'
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
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: PrimaryButton(
                      label: 'Conferma',
                      onPressed: () {
                        editoBloc.add(ArbEditorLanguageRemoved(currentLang));
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: SecondaryButton(
                      label: 'Annulla',
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
