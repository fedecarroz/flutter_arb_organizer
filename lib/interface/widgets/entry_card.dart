import 'package:flutter/material.dart';
import 'package:flutter_arb_organizer/data.dart';
import 'package:flutter_arb_organizer/interface/widgets/buttons.dart';
import 'package:flutter_arb_organizer/interface/widgets/card.dart';

class EntryCard extends StatelessWidget {
  final ArbDocument arbDoc;
  final int index;
  final void Function(String text, String language) onChanged;

  const EntryCard({
    Key? key,
    required this.arbDoc,
    required this.index,
    required this.onChanged,
  }) : super(key: key);

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
              Text(
                arbDoc.labels.keys.elementAt(index),
                style: TextStyle(
                  color: Colors.blue[800],
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              MouseRegion(
                child: PopupMenuButton(
                  itemBuilder: (context) {
                    return <PopupMenuItem>[
                      PopupMenuItem(
                        child: Row(
                          children: const <Widget>[
                            Icon(Icons.edit),
                            SizedBox(width: 10),
                            Text('Rinomina'),
                          ],
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
                      ),
                      PopupMenuItem(
                        child: Row(
                          children: const <Widget>[
                            Icon(Icons.delete),
                            SizedBox(width: 10),
                            Text('Elimina'),
                          ],
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
          for (var language in arbDoc.languages) ...[
            Row(
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
                    initialValue: arbDoc.labels.values
                        .elementAt(index)
                        .localizedValues[language],
                    onChanged: (text) => onChanged.call(text, language),
                  ),
                ),
              ],
            ),
            language == arbDoc.languages.last
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

            //TODO: Sezione scelta gruppo

            const SizedBox(height: 30),
            PrimaryButton(
              label: 'Aggiungi',
              onPressed: () {
                final entry = ArbEntry(
                  key: key,
                  localizedValues: values,
                  groupId: '', //TODO: gruppo
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
