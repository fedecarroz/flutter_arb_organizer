import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_improved_scrolling/flutter_improved_scrolling.dart';

import 'package:flutter_arb_organizer/helper.dart';
import 'package:flutter_arb_organizer/interface.dart';
import 'package:flutter_arb_organizer/logic.dart';

class RightSide extends StatelessWidget {
  final controller = ScrollController();

  RightSide({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<FileIOBloc, FileIOState>(
      listener: _listenerIO,
      child: Column(
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
                endScrollDurationBuilder:
                    (currentScrollOffset, maxScrollOffset) {
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
                        mainAxisExtent: 80 + (arbDoc.languages.length * 60),
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
      ),
    );
  }
}

void _listenerIO(
  BuildContext context,
  FileIOState state,
) {
  if (state is FileIOSaveComplete) {
    showDialog(
      context: context,
      builder: (_) {
        return Center(
          child: MainCard(
            width: 200,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const <Widget>[
                Text(
                  'Salvataggio riuscito',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  } else if (state is FileIOSaveFailure) {
    showDialog(
      context: context,
      builder: (_) {
        return Center(
          child: MainCard(
            width: 250,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const <Widget>[
                Text(
                  'Salvataggio non riuscito',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        );
      },
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
                        // TODO: fix
                        // final state = context.read<EditorMenuBloc>().state;
                        // if (state is EditorLanguageMenuRemoveStart) {
                        //   context
                        //     ..read<ArbEditorBloc>()
                        //         .add(ArbEditorLanguageRemoved(state.lang))
                        //     ..read<EditorMenuBloc>().add(LanguageMenuClicked());
                        // }
                      },
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: SecondaryButton(
                      label: 'Annulla',
                      onPressed: () {
                        // TODO: fix
                        // context
                        //   .read<EditorMenuBloc>()
                        //   .add(LanguageMenuClicked());
                      },
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
