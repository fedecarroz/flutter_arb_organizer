import 'package:flutter/material.dart';
import 'package:flutter_arb_organizer/interface.dart';
import 'package:flutter_arb_organizer/logic.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> showEditorGroupListDialog(BuildContext context) {
  final editoBloc = context.read<ArbEditorBloc>();
  return showDialog(
    context: context,
    builder: (context) => BlocProvider.value(
      value: editoBloc,
      child: const _GroupListDialog(),
    ),
  );
}

class _GroupListDialog extends StatelessWidget {
  const _GroupListDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            state.document.groups.values.elementAt(index),
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
                                icon: const Icon(Icons.delete_outline),
                                padding: const EdgeInsets.only(left: 0),
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
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> showEditorAddListDialog(BuildContext context) {
  final editoBloc = context.read<ArbEditorBloc>();
  return showDialog(
    context: context,
    builder: (context) => BlocProvider.value(
      value: editoBloc,
      child: const _GroupAddDialog(),
    ),
  );
}

class _GroupAddDialog extends StatelessWidget {
  const _GroupAddDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final groupNameController = TextEditingController();
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
                      hintText: 'Inserisci il nome del gruppo',
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
  }
}

Future<void> showEditorGroupEditDialog(BuildContext context) {
  final editoBloc = context.read<ArbEditorBloc>();
  return showDialog(
    context: context,
    builder: (context) => BlocProvider.value(
      value: editoBloc,
      child: const _GroupEditDialog(),
    ),
  );
}

class _GroupEditDialog extends StatelessWidget {
  const _GroupEditDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

Future<void> showEditorGroupRemoveDialog(BuildContext context) {
  final editoBloc = context.read<ArbEditorBloc>();
  return showDialog(
    context: context,
    builder: (context) => BlocProvider.value(
      value: editoBloc,
      child: const _GroupRemoveDialog(),
    ),
  );
}

class _GroupRemoveDialog extends StatelessWidget {
  const _GroupRemoveDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
