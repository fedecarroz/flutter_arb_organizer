import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_improved_scrolling/flutter_improved_scrolling.dart';

import 'package:flutter_arb_organizer/helper.dart';
import 'package:flutter_arb_organizer/logic.dart';

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

class _RightGroupMenu extends StatelessWidget {
  const _RightGroupMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class _RightLanguageMenu extends StatelessWidget {
  const _RightLanguageMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        //TODO: implementare
        );
  }
}