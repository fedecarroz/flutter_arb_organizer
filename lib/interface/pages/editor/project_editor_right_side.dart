import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_arb_organizer/interface.dart';
import 'package:flutter_arb_organizer/logic.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RightSide extends StatelessWidget {
  final controller = ScrollController();

  RightSide({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arbDoc = context.watch<ArbEditorBloc>().state.document;
    final filterState = context.watch<FilterCubit>().state;
    final filteredLabels = filterState.filterLabels(arbDoc.labels);

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
            child: GridView.builder(
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
                  arbDoc: arbDoc,
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
