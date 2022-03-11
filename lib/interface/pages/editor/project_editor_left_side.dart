import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_arb_organizer/logic.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
      child: BlocBuilder<EditorMenuBloc, EditorMenuState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  state.pageName,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: state is EditorMainMenuState
                    ? const _LeftMainMenu()
                    : state is EditorAllEntriesMenuState
                        ? const _LeftAllEntriesMenu()
                        : state is EditorGroupMenuState
                            ? const _LeftGroupMenu()
                            : const _LeftLanguageMenu(),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _LeftButton extends StatelessWidget {
  final MaterialColor baseColor;
  final bool centerText;
  final bool specialColor;
  final String label;
  final void Function()? onTap;
  final Color textColor;

  const _LeftButton({
    Key? key,
    this.baseColor = Colors.blue,
    this.centerText = false,
    this.specialColor = false,
    required this.label,
    required this.onTap,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: specialColor ? baseColor[900] : baseColor[700],
      child: InkWell(
        highlightColor: baseColor[900],
        hoverColor: baseColor[400],
        splashColor: baseColor[600],
        onTap: onTap,
        child: Container(
          height: 70,
          width: double.maxFinite,
          padding: centerText
              ? const EdgeInsets.all(0)
              : const EdgeInsets.only(left: 10),
          child: Align(
            alignment: centerText ? Alignment.center : Alignment.centerLeft,
            child: Text(
              label,
              style: TextStyle(
                color: textColor,
                fontSize: 18,
              ),
            ),
          ),
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

    return Column(
      children: <Widget>[
        _LeftButton(
          label: 'Etichette e info progetto',
          onTap: () =>
              context.read<EditorMenuBloc>().add(AllEntriesMenuClicked()),
        ),
        _LeftButton(
          label: 'Gestione gruppi',
          onTap: () => context.read<EditorMenuBloc>().add(GroupMenuClicked()),
        ),
        _LeftButton(
          label: 'Lingue supportate',
          onTap: () =>
              context.read<EditorMenuBloc>().add(LanguageMenuClicked()),
        ),
        const Expanded(child: SizedBox()),
        _LeftButton(
          centerText: true,
          specialColor: true,
          label: 'Esporta files .arb',
          onTap: () {},
        ),
      ],
    );
  }
}

class _LeftAllEntriesMenu extends StatelessWidget {
  const _LeftAllEntriesMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appLocal = AppLocalizations.of(context)!;

    return BlocBuilder<ArbEditorBloc, ArbEditorState>(
      builder: (context, state) {
        final arbDoc = state.document;

        return Column(
          children: <Widget>[
            _LeftButton(
              label: 'Nome progetto: ${arbDoc.projectName}',
              onTap: null,
            ),
            _LeftButton(
              label: 'Totale stringhe localizzate: ${arbDoc.labels.length}',
              onTap: null,
            ),
            _LeftButton(
              label: 'Gruppi creati: ${arbDoc.groups.length}',
              onTap: null,
            ),
            _LeftButton(
              label: 'Lingue supportate: ${arbDoc.languages.length}',
              onTap: null,
            ),
            const Expanded(child: SizedBox()),
            _LeftButton(
              centerText: true,
              specialColor: true,
              label: 'Indietro',
              onTap: () =>
                  context.read<EditorMenuBloc>().add(MainMenuClicked()),
            ),
          ],
        );
      },
    );
  }
}

class _LeftGroupMenu extends StatelessWidget {
  const _LeftGroupMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appLocal = AppLocalizations.of(context)!;

    return Column(
      children: <Widget>[
        BlocBuilder<ArbEditorBloc, ArbEditorState>(
          builder: (context, state) {
            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: state.document.groups.length,
              itemBuilder: (context, index) {
                return _LeftButton(
                  label: state.document.groups.values.elementAt(index),
                  onTap: () {},
                );
              },
            );
          },
        ),
        _LeftButton(
          centerText: true,
          label: '+',
          onTap: () {},
        ),
        const Expanded(child: SizedBox()),
        _LeftButton(
          centerText: true,
          specialColor: true,
          label: 'Indietro',
          onTap: () => context.read<EditorMenuBloc>().add(MainMenuClicked()),
        ),
      ],
    );
  }
}

class _LeftLanguageMenu extends StatelessWidget {
  const _LeftLanguageMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appLocal = AppLocalizations.of(context)!;
    final arbLangs = context.watch<ArbEditorBloc>().state.document.languages;
    return Column(
      children: [
        for (final lang in arbLangs)
          _LeftButton(
            centerText: true,
            label: lang,
            onTap: () => context.read<EditorMenuBloc>().add(
                  LanguageMenuUpdateClicked(lang),
                ),
          ),
        _LeftButton(
          centerText: true,
          label: '+',
          onTap: () => context.read<EditorMenuBloc>().add(
                LanguageMenuAddClicked(),
              ),
        ),
        const Expanded(child: SizedBox()),
        _LeftButton(
          centerText: true,
          specialColor: true,
          label: 'Indietro',
          onTap: () => context.read<EditorMenuBloc>().add(MainMenuClicked()),
        ),
      ],
    );
  }
}
