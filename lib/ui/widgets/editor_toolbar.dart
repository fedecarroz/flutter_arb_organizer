import 'package:flutter/material.dart';
import 'package:flutter_arb_organizer/ui.dart';
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
        return Container(
          color: Colors.blue[900],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _SearchBar(
                showSearchInput: showSearchInput,
                onTextChange: (text) =>
                    context.read<FilterCubit>().changeText(text),
              ),
              const _AddEntryButton(),
              const _FilterButton(),
              const _GroupsButton(),
              const _LanguagesButton(),
              const _SaveButton(),
              _ExitButton(
                onTap: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SearchBar extends StatelessWidget {
  final bool showSearchInput;
  final void Function(String text)? onTextChange;

  const _SearchBar({
    Key? key,
    required this.showSearchInput,
    this.onTextChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(15),
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(100),
        ),
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
                onChanged: onTextChange?.call,
              ),
            ),
          ],
        ),
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
        onTap: () async {
          final filterCubit = context.read<FilterCubit>();
          final result = await showEditorFilterDialog(context);
          if (result != null) {
            filterCubit.changeFilters(result);
          }
        },
      ),
    );
  }
}

class _ExitButton extends StatelessWidget {
  final void Function() onTap;

  const _ExitButton({
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
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Icon(
              Icons.exit_to_app_outlined,
              color: Colors.white,
              size: 30,
            ),
            Text(
              'Esci',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
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
        onTap: () => showEditorGroupListDialog(context),
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
