import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_arb_organizer/ui.dart';

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
          children: <Widget>[
            const Flexible(
              flex: 1,
              child: LeftSide(),
            ),
            Flexible(
              flex: 4,
              child: RightSide(),
            ),
          ],
        ),
      ),
    );
  }
}
