import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_arb_organizer/data.dart';
import 'package:flutter_arb_organizer/helper.dart';
import 'package:flutter_arb_organizer/interface.dart';
import 'package:flutter_arb_organizer/logic.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_improved_scrolling/flutter_improved_scrolling.dart';

class RightSide extends StatelessWidget {
  const RightSide({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditorMenuBloc, EditorMenuState>(
      builder: (context, state) {
        return state is EditorAllEntriesMenuState
            ? const _RightAllEntriesMenu()
            : state is EditorGroupMenuState
                ? const _RightGroupMenu()
                : const _RightLanguageMenu();
      },
    );
  }
}

class _RightAllEntriesMenu extends StatefulWidget {
  const _RightAllEntriesMenu({Key? key}) : super(key: key);

  @override
  State<_RightAllEntriesMenu> createState() => _RightAllEntriesMenuState();
}

class _RightAllEntriesMenuState extends State<_RightAllEntriesMenu> {
  final controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    final appLocal = AppLocalizations.of(context)!;

    return Column(
      children: <Widget>[
        Container(
          height: appWindow.titleBarHeight + 20,
          color: Colors.blue[900],
          alignment: Alignment.topCenter,
        ),
        const EditorToolbar(),
        const SizedBox(height: 20),
        Expanded(
          child: ImprovedScrolling(
            scrollController: controller,
            enableMMBScrolling: true,
            enableKeyboardScrolling: true,
            enableCustomMouseWheelScrolling: true,
            mmbScrollConfig: const MMBScrollConfig(
              customScrollCursor: DefaultCustomScrollCursor(),
            ),
            keyboardScrollConfig: KeyboardScrollConfig(
              arrowsScrollAmount: 250.0,
              homeScrollDurationBuilder:
                  (currentScrollOffset, minScrollOffset) {
                return const Duration(milliseconds: 100);
              },
              endScrollDurationBuilder: (currentScrollOffset, maxScrollOffset) {
                return const Duration(milliseconds: 2000);
              },
            ),
            customMouseWheelScrollConfig: const CustomMouseWheelScrollConfig(
              scrollAmountMultiplier: 20.0,
              scrollDuration: Duration(milliseconds: 200),
              scrollCurve: Curves.linear,
            ),
            child: ScrollConfiguration(
              behavior: const CustomScrollBehaviour(),
              child: BlocBuilder<ArbEditorBloc, ArbEditorState>(
                builder: (context, state) {
                  final arbDoc = state.document;
                  return GridView.builder(
                    controller: controller,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: arbDoc.labels.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20,
                      mainAxisExtent: (arbDoc.languages.length + 1) * 60,
                      mainAxisSpacing: 20,
                    ),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return EntryCard(
                        arbDoc: state.document,
                        index: index,
                        onChanged: (value, language) {
                          var newLocalizedValues = arbDoc.labels.values
                              .elementAt(index)
                              .localizedValues;

                          newLocalizedValues[language] = value;

                          context.read<ArbEditorBloc>().add(
                                ArbEditorEntryUpdated(
                                  arbDoc.labels.values
                                      .elementAt(index)
                                      .copyWith(
                                        localizedValues: newLocalizedValues,
                                      ),
                                ),
                              );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

class _RightGroupMenu extends StatelessWidget {
  const _RightGroupMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditorMenuBloc, EditorMenuState>(
      builder: (context, state) {
        if (state is EditorGroupMenuAddStart) {
          return _RightGroupAddMenu();
        } else if (state is EditorGroupMenuUpdateStart) {
          return const _RightGroupUpdateMenu();
        } else if (state is EditorGroupMenuRemoveStart) {
          return const _RightGroupRemoveMenu();
        } else {
          return const FlutterArbLogo();
        }
      },
    );
  }
}

class _RightGroupAddMenu extends StatelessWidget {
  final groupNameController = TextEditingController();
  _RightGroupAddMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MainCard(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const CardHeader(
              title: 'Aggiungi un nuovo gruppo',
            ),
            const SizedBox(height: 10),
            Row(
              children: <Widget>[
                Text(
                  'Nome gruppo:',
                  style: TextStyle(
                    color: Colors.blue[800],
                    fontSize: 18,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Inserisci il nome del gruppo',
                    ),
                    controller: groupNameController,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: <Widget>[
                Expanded(
                  child: SecondaryButton(
                    label: 'Annulla',
                    onPressed: () {
                      groupNameController.clear();
                      context.read<EditorMenuBloc>().add(GroupMenuClicked());
                    },
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: PrimaryButton(
                    label: 'Aggiungi',
                    onPressed: () {
                      context
                        ..read<ArbEditorBloc>().add(
                            ArbEditorGroupCreated(groupNameController.text))
                        ..read<EditorMenuBloc>().add(GroupMenuClicked());
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

class _RightGroupUpdateMenu extends StatelessWidget {
  const _RightGroupUpdateMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class _RightGroupRemoveMenu extends StatelessWidget {
  const _RightGroupRemoveMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class _RightLanguageMenu extends StatelessWidget {
  const _RightLanguageMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ArbEditorBloc, ArbEditorState>(
      listener: (context, state) {
        if (state is ArbEditorDocumentUpdateSuccess) {
          context.read<EditorMenuBloc>().add(LanguageMenuClicked());
        }
      },
      child: BlocBuilder<EditorMenuBloc, EditorMenuState>(
        builder: (context, state) {
          if (state is EditorLanguageMenuAddStart) {
            return const _RightLanguageAddMenu();
          } else if (state is EditorLanguageMenuUpdateStart) {
            return const _RightLanguageUpdateMenu();
          } else if (state is EditorLanguageMenuRemoveStart) {
            return const _RightLanguageRemoveMenu();
          } else {
            return const FlutterArbLogo();
          }
        },
      ),
    );
  }
}

class _RightLanguageAddMenu extends StatelessWidget {
  const _RightLanguageAddMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final languages = context.watch<ArbEditorBloc>().state.document.languages;

    final languagesAvailable =
        LanguagesSupported.values.where((l) => !languages.contains(l));

    return Center(
      child: LangSelectCard(
        languages: languagesAvailable.toList(),
        title: 'Aggiungi lingua',
        onLanguageClick: (lang) => context.read<ArbEditorBloc>().add(
              ArbEditorLanguageAdded(lang),
            ),
      ),
    );
  }
}

class _RightLanguageUpdateMenu extends StatelessWidget {
  const _RightLanguageUpdateMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final languages = context.watch<ArbEditorBloc>().state.document.languages;

    final languagesAvailable =
        LanguagesSupported.values.where((l) => !languages.contains(l));

    return Center(
      child: LangSelectCard(
        languages: languagesAvailable.toList(),
        title: 'Cambia lingua',
        onLanguageClick: (lang) {
          final editorMenuState = context.read<EditorMenuBloc>().state;
          if (editorMenuState is EditorLanguageMenuUpdateStart) {
            context.read<ArbEditorBloc>().add(
                  ArbEditorLanguageUpdated(
                    oldLang: editorMenuState.currentLang,
                    newLang: lang,
                  ),
                );
          }
        },
      ),
    );
  }
}

class _RightLanguageRemoveMenu extends StatelessWidget {
  const _RightLanguageRemoveMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                        final state = context.read<EditorMenuBloc>().state;
                        if (state is EditorLanguageMenuRemoveStart) {
                          context
                            ..read<ArbEditorBloc>()
                                .add(ArbEditorLanguageRemoved(state.lang))
                            ..read<EditorMenuBloc>().add(LanguageMenuClicked());
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: SecondaryButton(
                      label: 'Annulla',
                      onPressed: () => context
                          .read<EditorMenuBloc>()
                          .add(LanguageMenuClicked()),
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
