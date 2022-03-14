import 'package:flutter/material.dart';
import 'package:flutter_arb_organizer/interface.dart';
import 'package:flutter_arb_organizer/logic.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditorToolbar extends StatefulWidget {
  const EditorToolbar({Key? key}) : super(key: key);

  @override
  State<EditorToolbar> createState() => _EditorToolbarState();
}

class _EditorToolbarState extends State<EditorToolbar> {
  bool showSearchInput = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, boxConstr) {
      final maxSearchTextInputWidth = boxConstr.maxWidth - 70 * 6 - 30;

      return Container(
        color: Colors.blue[900],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedContainer(
              duration: const Duration(milliseconds: 0),
              margin: const EdgeInsets.all(15),
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
              ),
              width: showSearchInput ? maxSearchTextInputWidth : 0,
              height: 40,
              child: Row(
                children: [
                  const Icon(Icons.search, size: 20),
                  const SizedBox(width: 15),
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(bottom: 10),
                        hintText: 'Cerca...',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 70,
              child: EditorButton.widget(
                centerText: true,
                specialColor: true,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 30,
                    ),
                    Text(
                      'Aggiungi',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) {
                      return Material(
                        color: Colors.transparent,
                        child: Container(
                          alignment: Alignment.center,
                          child: NewEntryCard(
                            arbDoc:
                                context.watch<ArbEditorBloc>().state.document,
                            onPressed: (arbEntry) {
                              context
                                  .read<ArbEditorBloc>()
                                  .add(ArbEditorEntryAdded(arbEntry));
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            SizedBox(
              width: 70,
              child: EditorButton.widget(
                centerText: true,
                specialColor: true,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Icon(
                      Icons.filter_alt_outlined,
                      color: Colors.white,
                      size: 30,
                    ),
                    Text(
                      'Filtra',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) {
                      final state = context.watch<ArbEditorBloc>().state;
                      return Center(
                        child: MainCard(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              CardHeader(
                                title: 'Filtra',
                                onBack: () => Navigator.of(context).pop(),
                              ),
                              const SizedBox(height: 20),
                              state.document.groups.isEmpty
                                  ? const Text(
                                      'Nessun gruppo trovato',
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    )
                                  : ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: state.document.groups.length,
                                      itemBuilder: (context, index) {
                                        return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              state.document.groups.values
                                                  .elementAt(index),
                                            ),
                                            Checkbox(
                                              value: false,
                                              onChanged: (value) {},
                                            ),
                                          ],
                                        );
                                      },
                                    )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            SizedBox(
              width: 70,
              child: EditorButton.widget(
                centerText: true,
                specialColor: true,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 30,
                    ),
                    Text(
                      'Ricerca',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  setState(() => showSearchInput = !showSearchInput);
                },
              ),
            ),
            SizedBox(
              width: 70,
              child: EditorButton.widget(
                centerText: true,
                specialColor: true,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Icon(
                      Icons.label_outline,
                      color: Colors.white,
                      size: 30,
                    ),
                    Text(
                      'Gruppi',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                onTap: () =>
                    context.read<EditorMenuBloc>().add(GroupMenuClicked()),
              ),
            ),
            SizedBox(
              width: 70,
              child: EditorButton.widget(
                centerText: true,
                specialColor: true,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Icon(
                      Icons.language,
                      color: Colors.white,
                      size: 30,
                    ),
                    Text(
                      'Lingue',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                onTap: () =>
                    context.read<EditorMenuBloc>().add(LanguageMenuClicked()),
              ),
            ),
            SizedBox(
              width: 70,
              child: EditorButton.widget(
                centerText: true,
                specialColor: true,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Icon(
                      Icons.save,
                      color: Colors.white,
                      size: 30,
                    ),
                    Text(
                      'Salva',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  final doc = context.read<ArbEditorBloc>().state.document;
                  context.read<FileIOBloc>().add(FileIOArbDocSaved(doc));
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}
