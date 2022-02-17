import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_improved_scrolling/flutter_improved_scrolling.dart';

import 'package:flutter_arb_organizer/helper.dart';

class ProjectEditorPage extends StatelessWidget {
  const ProjectEditorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              flex: 3,
              child: _RightSide(),
            ),
          ],
        ),
      ),
      floatingActionButton: _FAB(),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Nome del progetto'.toString(),
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) => Center(
                          child: Container(
                            color: Colors.white,
                            height: 100,
                            width: 200,
                            child: const Center(
                              child: Text('Impostazioni(Ordina/salva/esporta)'),
                            ),
                          ),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: const Icon(
                        Icons.more_horiz_rounded,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          for (int index = 0; index < 3; index++) ...[
            _LeftButton(
              isSelected: index == 0 ? true : false,
              label: 'Gruppo ${index + 1}',
            ),
          ],
          const Expanded(child: SizedBox()),
          const _LeftButton(
            isSelected: false,
            label: '+',
            centerText: true,
          ),
        ],
      ),
    );
  }
}

class _LeftButton extends StatelessWidget {
  final bool isSelected;
  final String label;
  final bool centerText;

  const _LeftButton({
    Key? key,
    required this.isSelected,
    required this.label,
    this.centerText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected ? Colors.blue[900] : Colors.blue[700],
      child: InkWell(
        onTap: () {},
        hoverColor: Colors.blue[300],
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
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
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
                  crossAxisSpacing: 50,
                  mainAxisExtent: 180,
                  mainAxisSpacing: 10,
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
