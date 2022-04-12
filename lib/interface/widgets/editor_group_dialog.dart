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
    final editorBloc = context.watch<ArbEditorBloc>();
    final state = editorBloc.state;

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
                : SizedBox(
                    height: 300,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.document.groups.length,
                      itemBuilder: (context, index) {
                        final group =
                            state.document.groups.entries.elementAt(index);

                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              group.value,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                IconButton(
                                  onPressed: () => showEditorGroupEditDialog(
                                    context,
                                    group,
                                  ),
                                  icon: const Icon(Icons.edit),
                                ),
                                IconButton(
                                  onPressed: () => _showEditorGroupRemoveDialog(
                                    context,
                                    group.key,
                                  ),
                                  icon: const Icon(Icons.delete_outline),
                                  padding: const EdgeInsets.only(left: 0),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  ),
            const SizedBox(height: 20),
            PrimaryButton(
              label: 'Nuovo gruppo',
              onPressed: () => _showEditorAddListDialog(context),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> _showEditorAddListDialog(BuildContext context) {
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

Future<void> showEditorGroupEditDialog(
  BuildContext context,
  MapEntry<String, String> groupEntry,
) {
  final editoBloc = context.read<ArbEditorBloc>();
  return showDialog(
    context: context,
    builder: (context) => BlocProvider.value(
      value: editoBloc,
      child: _GroupEditDialog(
        groupId: groupEntry.key,
        groupName: groupEntry.value,
      ),
    ),
  );
}

class _GroupEditDialog extends StatelessWidget {
  final String groupId;
  final String groupName;
  final groupNameController = TextEditingController();

  _GroupEditDialog({
    Key? key,
    required this.groupId,
    required this.groupName,
  }) : super(key: key) {
    groupNameController.text = groupName;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MainCard(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CardHeader(
              title: 'Modifica gruppo',
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
              label: 'Aggiorna gruppo',
              onPressed: () {
                context.read<ArbEditorBloc>().add(
                      ArbEditorGroupNameUpdated(
                        groupId: groupId,
                        groupName: groupNameController.text,
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

Future<void> _showEditorGroupRemoveDialog(
    BuildContext context, String groupId) {
  final editoBloc = context.read<ArbEditorBloc>();
  return showDialog(
    context: context,
    builder: (context) => BlocProvider.value(
      value: editoBloc,
      child: _GroupRemoveDialog(groupId: groupId),
    ),
  );
}

class _GroupRemoveDialog extends StatefulWidget {
  final String groupId;

  const _GroupRemoveDialog({Key? key, required this.groupId}) : super(key: key);

  @override
  State<_GroupRemoveDialog> createState() => _GroupRemoveDialogState();
}

class _GroupRemoveDialogState extends State<_GroupRemoveDialog> {
  bool removeGroupLabels = false;

  @override
  Widget build(BuildContext context) {
    final editoBloc = context.watch<ArbEditorBloc>();

    return Center(
      child: MainCard.dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CardHeader(
              title: 'Rimuovi gruppo',
              onBack: () => Navigator.pop(context),
            ),
            const SizedBox(height: 15),
            RichText(
              text: const TextSpan(
                text: 'Sei sicuro di voler rimuovere il gruppo selezionato?'
                    'Il processo è ',
                style: TextStyle(
                  color: Colors.black,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: 'irreversibile',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(text: '.')
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text('Cancella anche le etichette'),
                  Checkbox(
                    value: removeGroupLabels,
                    onChanged: (v) => setState(
                      () => removeGroupLabels = v ?? false,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: SecondaryButton(
                      label: 'Annulla',
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: PrimaryButton(
                      label: 'Conferma',
                      onPressed: () {
                        editoBloc.add(
                          ArbEditorGroupRemoved(
                            groupId: widget.groupId,
                            removeEntries: removeGroupLabels,
                          ),
                        );
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
