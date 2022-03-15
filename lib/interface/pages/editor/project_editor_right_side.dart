import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_arb_organizer/helper.dart';
import 'package:flutter_arb_organizer/interface.dart';
import 'package:flutter_arb_organizer/logic.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_improved_scrolling/flutter_improved_scrolling.dart';

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
                    final filterState = context.watch<FilterCubit>().state;
                    final filteredLabels =
                        filterState.filterLabels(arbDoc.labels);

                    return GridView.builder(
                      controller: controller,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: filteredLabels.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 20,
                        mainAxisExtent: 80 + (arbDoc.languages.length * 60),
                        mainAxisSpacing: 20,
                      ),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final entry = filteredLabels.values.elementAt(index);

                        return EntryCard(
                          entry: entry,
                          languages: arbDoc.languages,
                          onChanged: (value, language) {
                            var newLocalizedValues = entry.localizedValues;

                            newLocalizedValues[language] = value;

                            context.read<ArbEditorBloc>().add(
                                  ArbEditorEntryUpdated(
                                    entry.copyWith(
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
        Future.delayed(const Duration(seconds: 2))
            .then((_) => Navigator.pop(context));
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
        Future.delayed(const Duration(seconds: 2))
            .then((_) => Navigator.pop(context));

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
