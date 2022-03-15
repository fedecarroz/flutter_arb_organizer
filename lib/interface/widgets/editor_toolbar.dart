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
    return LayoutBuilder(
      builder: (context, boxConstr) {
        final maxSearchTextInputWidth = boxConstr.maxWidth - 70 * 6 - 30;

        return Container(
          color: Colors.blue[900],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _SearchBar(
                showSearchInput: showSearchInput,
                maxSearchTextInputWidth: maxSearchTextInputWidth,
              ),
              const _AddEntryButton(),
              const _FilterButton(),
              _SearchButton(
                onTap: () => setState(() => showSearchInput = !showSearchInput),
              ),
              const _GroupsButton(),
              const _LanguagesButton(),
              const _SaveButton(),
            ],
          ),
        );
      },
    );
  }
}

class _SearchBar extends StatelessWidget {
  final bool showSearchInput;
  final double maxSearchTextInputWidth;

  const _SearchBar({
    Key? key,
    required this.showSearchInput,
    required this.maxSearchTextInputWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
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
        children: <Widget>[
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
    );
  }
}

class _AddEntryButton extends StatelessWidget {
  const _AddEntryButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
              final arbDoc = context.watch<ArbEditorBloc>().state.document;
              return NewEntryCard(
                arbDoc: arbDoc,
                onPressed: (arbEntry) {
                  context
                      .read<ArbEditorBloc>()
                      .add(ArbEditorEntryAdded(arbEntry));
                },
              );
            },
          );
        },
      ),
    );
  }
}

class _FilterButton extends StatelessWidget {
  const _FilterButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state.document.groups.length,
                        itemBuilder: (context, index) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                state.document.groups.values.elementAt(index),
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
    );
  }
}

class _SearchButton extends StatelessWidget {
  final void Function() onTap;

  const _SearchButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
        onTap: onTap,
      ),
    );
  }
}

class _GroupsButton extends StatelessWidget {
  const _GroupsButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                        title: 'Gestione gruppi',
                        onBack: () => Navigator.of(context).pop(),
                      ),
                      const SizedBox(height: 20),
                      state.document.groups.isEmpty
                          ? Text(
                              'Nessun gruppo trovato',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[600],
                              ),
                            )
                          : ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
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
                                      style: const TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                    Row(
                                      children: <Widget>[
                                        IconButton(
                                          onPressed: () {},
                                          icon: const Icon(Icons.edit),
                                        ),
                                        IconButton(
                                          onPressed: () {},
                                          icon:
                                              const Icon(Icons.delete_outline),
                                          padding:
                                              const EdgeInsets.only(left: 0),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              },
                            ),
                      const SizedBox(height: 20),
                      PrimaryButton(
                        label: 'Nuovo gruppo',
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (_) {
                              final groupNameController =
                                  TextEditingController();
                              return Center(
                                child: MainCard(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      CardHeader(
                                        title: 'Aggiungi gruppo',
                                        onBack: () {
                                          groupNameController.clear();
                                          Navigator.of(context).pop();
                                        },
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
                                                hintText:
                                                    'Inserisci il nome del gruppo',
                                              ),
                                              controller: groupNameController,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 20),
                                      PrimaryButton(
                                        label: 'Aggiungi gruppo',
                                        onPressed: () {
                                          context.read<ArbEditorBloc>().add(
                                                ArbEditorGroupCreated(
                                                  groupNameController.text,
                                                ),
                                              );
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _LanguagesButton extends StatelessWidget {
  const _LanguagesButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
        onTap: () {
          final editorBloc = context.read<ArbEditorBloc>();
          showEditorLanguageListDialog(context, editorBloc);
        },
      ),
    );
  }
}

class _SaveButton extends StatelessWidget {
  const _SaveButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
    );
  }
}
