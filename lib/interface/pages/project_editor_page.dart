import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_improved_scrolling/flutter_improved_scrolling.dart';

import 'package:flutter_arb_organizer/helper.dart';
import 'package:flutter_arb_organizer/logic.dart';

class ProjectEditorPage extends StatefulWidget {
  const ProjectEditorPage({Key? key}) : super(key: key);

  @override
  State<ProjectEditorPage> createState() => _ProjectEditorPageState();
}

class _ProjectEditorPageState extends State<ProjectEditorPage> {
  @override
  void initState() {
    super.initState();
    context.read<EditorMenuBloc>().add(MainMenuClicked('Nome del progetto'));
  }

  @override
  Widget build(BuildContext context) {
    final appLocal = AppLocalizations.of(context)!;
    
    return Scaffold(
      backgroundColor: Colors.blue,
      body: DropTarget(
        onDragDone: (details) {
          final files = details.files;
          print(files);
        },
        child: Flex(
          direction: Axis.horizontal,
          children: const <Widget>[
            Flexible(
              flex: 1,
              child: _LeftSide(),
            ),
            Flexible(
              flex: 4,
              child: _RightSide(),
            ),
          ],
        ),
      ),
      floatingActionButton: const _FAB(),
    );
  }
}

class _LeftSide extends StatelessWidget {
  const _LeftSide({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[700],
      width: double.maxFinite,
      padding: EdgeInsets.only(
        top: appWindow.titleBarHeight + 20,
      ),
      child: Builder(
        builder: (context) {
          final _menuState = context.watch<EditorMenuBloc>().state;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  _menuState.title,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: _menuState is EditorMainMenuState
                    ? const _MainMenu()
                    : _menuState is EditorGroupMenuState
                        ? const _GroupMenu()
                        : const _LanguageMenu(),
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
  final bool isSelected;
  final String label;
  final void Function()? onTap;
  final Color textColor;

  const _LeftButton({
    Key? key,
    this.baseColor = Colors.blue,
    this.centerText = false,
    required this.isSelected,
    required this.label,
    required this.onTap,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected ? baseColor[900] : baseColor[700],
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

class _MainMenu extends StatelessWidget {
  const _MainMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _LeftButton(
          isSelected: false,
          label: 'Gruppi',
          onTap: () =>
              context.read<EditorMenuBloc>().add(GroupMenuClicked('Gruppi')),
        ),
        _LeftButton(
          isSelected: false,
          label: 'Lingue',
          onTap: () =>
              context.read<EditorMenuBloc>().add(LanguageMenuClicked('Lingue')),
        ),
        const Expanded(child: SizedBox()),
        _LeftButton(
          baseColor: Colors.deepOrange,
          centerText: true,
          isSelected: false,
          label: 'Esporta',
          onTap: () {},
        ),
      ],
    );
  }
}

class _GroupMenu extends StatelessWidget {
  const _GroupMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _LeftButton(
          centerText: true,
          isSelected: false,
          label: '+',
          onTap: () {},
        ),
        const Expanded(child: SizedBox()),
        _LeftButton(
          centerText: true,
          isSelected: false,
          label: 'Indietro',
          onTap: () => context
              .read<EditorMenuBloc>()
              .add(MainMenuClicked('Nome del progetto')),
        ),
      ],
    );
  }
}

class _LanguageMenu extends StatelessWidget {
  const _LanguageMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _LeftButton(
          centerText: true,
          isSelected: false,
          label: '+',
          onTap: () {},
        ),
        const Expanded(child: SizedBox()),
        _LeftButton(
          centerText: true,
          isSelected: false,
          label: 'Indietro',
          onTap: () => context
              .read<EditorMenuBloc>()
              .add(MainMenuClicked('Nome del progetto')),
        ),
      ],
    );
  }
}

class _RightSide extends StatefulWidget {
  const _RightSide({Key? key}) : super(key: key);

  @override
  State<_RightSide> createState() => _RightSideState();
}

class _RightSideState extends State<_RightSide> {
  final controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
              child: GridView.builder(
                controller: controller,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: 20,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisExtent: 180,
                  mainAxisSpacing: 20,
                ),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Entry ${index + 1}',
                            style: TextStyle(
                              color: Colors.blue[800],
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: <Widget>[
                              SizedBox(
                                width: 70,
                                child: Text(
                                  'it_IT:',
                                  style: TextStyle(
                                    color: Colors.blue[800],
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    hintText: 'Inserire testo',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: <Widget>[
                              SizedBox(
                                width: 70,
                                child: Text(
                                  'en_US:',
                                  style: TextStyle(
                                    color: Colors.blue[800],
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    hintText: 'Inserire testo',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _FAB extends StatelessWidget {
  const _FAB({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      width: 70,
      child: FittedBox(
        child: FloatingActionButton(
          backgroundColor: Colors.blue[800],
          focusColor: Colors.blue[900],
          splashColor: Colors.blue[900],
          hoverColor: Colors.blue[800],
          onPressed: () {},
          child: const Icon(
            Icons.save,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
