import 'package:flutter/material.dart';
import 'package:flutter_arb_organizer/data.dart';
import 'package:flutter_arb_organizer/interface/widgets.dart';

class EntryCard extends StatefulWidget {
  final ArbDocument arbDoc;
  final ArbEntry entry;
  final void Function(String text, String language) onChanged;

  const EntryCard({
    Key? key,
    required this.arbDoc,
    required this.entry,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<EntryCard> createState() => _EntryCardState();
}

class _EntryCardState extends State<EntryCard> {
  final Map<String, TextEditingController> controllers = {};

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    widget.entry.key,
                    style: TextStyle(
                      color: Colors.blue[800],
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: widget.arbDoc.groups[widget.entry.groupId] == null
                          ? Colors.grey
                          : Colors.blue[800],
                      borderRadius: BorderRadius.circular(6),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 3,
                    ),
                    child: Center(
                      child: Text(
                        widget.arbDoc.groups[widget.entry.groupId] ??
                            'Nessun gruppo',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              MouseRegion(
                child: PopupMenuButton(
                  itemBuilder: (_) {
                    return <PopupMenuItem>[
                      PopupMenuItem(
                        child: Row(
                          children: const <Widget>[
                            Icon(Icons.edit),
                            SizedBox(width: 10),
                            Text('Rinomina'),
                          ],
                        ),
                        onTap: () => Future(
                          () => showRenameDialog(context, widget.entry),
                        ),
                      ),
                      PopupMenuItem(
                        child: Row(
                          children: const <Widget>[
                            Icon(Icons.label),
                            SizedBox(width: 10),
                            Text('Imposta gruppo'),
                          ],
                        ),
                        onTap: () => Future(
                          () => showSetGroupDialog(context, widget.entry),
                        ),
                      ),
                      PopupMenuItem(
                        child: Row(
                          children: const <Widget>[
                            Icon(Icons.delete),
                            SizedBox(width: 10),
                            Text('Elimina'),
                          ],
                        ),
                        onTap: () => Future(
                          () => showDeleteEntryDialog(context, widget.entry),
                        ),
                      ),
                    ];
                  },
                  icon: Icon(
                    Icons.more_vert,
                    color: Colors.blue[800],
                  ),
                  elevation: 6,
                  tooltip: 'Modifica',
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          for (var language in widget.arbDoc.languages) ...[
            Builder(builder: (context) {
              final controller = TextEditingController.fromValue(
                TextEditingValue(
                  text: widget.entry.localizedValues[language] ?? '',
                  selection: TextSelection.collapsed(
                    offset:
                        controllers[language]?.value.selection.baseOffset ?? -1,
                  ),
                ),
              );

              controllers[language] = controller;

              return Row(
                children: <Widget>[
                  SizedBox(
                    width: 70,
                    child: Text(
                      '$language:',
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
                      controller: controllers[language]!,
                      onChanged: (text) =>
                          widget.onChanged.call(text, language),
                    ),
                  ),
                ],
              );
            }),
            language == widget.arbDoc.languages.last
                ? const SizedBox()
                : const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }
}

class NewEntryCard extends StatefulWidget {
  final ArbDocument arbDoc;
  final void Function(ArbEntry arbEntry)? onPressed;

  const NewEntryCard({
    Key? key,
    required this.arbDoc,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<NewEntryCard> createState() => _NewEntryCardState();
}

class _NewEntryCardState extends State<NewEntryCard> {
  String key = '';
  Map<String, String> values = {};
  String dropdownValue = '';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MainCard(
        width: 500,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CardHeader(
              title: 'Aggiungi nuova entry',
              onBack: () => Navigator.of(context).pop(),
            ),
            const SizedBox(height: 20),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 80,
                  child: Text(
                    'Chiave:',
                    style: TextStyle(
                      color: Colors.blue[800],
                      fontSize: 18,
                    ),
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Inserire la chiave',
                    ),
                    onChanged: (text) {
                      setState(() {
                        key = text;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 80,
                  child: Text(
                    'Gruppo:',
                    style: TextStyle(
                      color: Colors.blue[800],
                      fontSize: 18,
                    ),
                  ),
                ),
                Expanded(
                  child: DropdownButton<String>(
                    items: [
                      DropdownMenuItem(
                        value: '',
                        onTap: () {
                          setState(() {
                            dropdownValue = '';
                          });
                        },
                        child: const Text('Nessun gruppo'),
                      ),
                      ...widget.arbDoc.groups.entries.map(
                        (e) => DropdownMenuItem(
                          value: e.key,
                          onTap: () {
                            setState(() {
                              dropdownValue = e.key;
                            });
                          },
                          child: Text(e.value),
                        ),
                      ),
                    ],
                    value: dropdownValue,
                    isExpanded: true,
                    focusColor: Colors.transparent,
                    onChanged: (_) {},
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            for (var language in widget.arbDoc.languages) ...[
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 80,
                    child: Text(
                      '$language:',
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
                      onChanged: (text) {
                        setState(() {
                          values[language] = text;
                        });
                      },
                    ),
                  ),
                ],
              ),
              language == widget.arbDoc.languages.last
                  ? const SizedBox()
                  : const SizedBox(height: 10),
            ],
            const SizedBox(height: 30),
            PrimaryButton(
              label: 'Aggiungi',
              onPressed: () {
                final entry = ArbEntry(
                  key: key,
                  localizedValues: values,
                  groupId: dropdownValue,
                );

                widget.onPressed?.call(entry);

                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
