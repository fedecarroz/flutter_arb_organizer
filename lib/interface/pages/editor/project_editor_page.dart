import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_arb_organizer/interface.dart';
import 'package:flutter_arb_organizer/logic.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProjectEditorPage extends StatefulWidget {
  const ProjectEditorPage({Key? key}) : super(key: key);

  @override
  State<ProjectEditorPage> createState() => ProjectEditorPageState();
}

class ProjectEditorPageState extends State<ProjectEditorPage> {
  @override
  void initState() {
    super.initState();
    context.read<EditorMenuBloc>().add(AllEntriesMenuClicked());
  }

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
