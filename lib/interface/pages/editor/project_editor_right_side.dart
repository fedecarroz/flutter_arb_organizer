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
        return state is EditorMainMenuState
            ? const _RightMainMenu()
            : state is EditorAllEntriesMenuState
                ? const _RightAllEntriesMenu()
                : state is EditorGroupMenuState
                    ? const _RightGroupMenu()
                    : const _RightLanguageMenu();
      },
    );
  }
}

class _RightMainMenu extends StatelessWidget {
  const _RightMainMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.text_fields,
          color: Colors.blue[100]!.withOpacity(0.3),
          size: 250,
        ),
        const SizedBox(width: 30),
        Text(
          'Flutter ARB Organizer',
          style: TextStyle(
            color: Colors.blue[100]!.withOpacity(0.3),
            fontSize: 50,
          ),
        ),
      ],
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
          margin: const EdgeInsets.only(right: 10),
          color: Colors.blue,
          alignment: Alignment.topCenter,
        ),
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
                        onChanged: (value,language) {
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
    return Container(); //TODO: implementare
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
          } else {
            return Container();
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
