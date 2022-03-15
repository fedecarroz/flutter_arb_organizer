import 'package:flutter/material.dart';
import 'package:flutter_arb_organizer/interface.dart';
import 'package:flutter_arb_organizer/logic.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<List<String>?> showEditorFilterDialog(BuildContext context) {
  final editorBloc = context.read<ArbEditorBloc>();
  final filersCubit = context.read<FilterCubit>();

  return showDialog<List<String>?>(
    context: context,
    builder: (context) => MultiBlocProvider(
      providers: [
        BlocProvider<ArbEditorBloc>.value(value: editorBloc),
      ],
      child: _FilterDialog(
        initialGroupIdSelected: filersCubit.state.groupIdsSelected.toSet(),
      ),
    ),
  );
}

class _FilterDialog extends StatefulWidget {
  final Set<String> initialGroupIdSelected;

  const _FilterDialog({
    Key? key,
    this.initialGroupIdSelected = const <String>{},
  }) : super(key: key);

  @override
  State<_FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<_FilterDialog> {
  late Set<String> groupIdSelected;

  @override
  void initState() {
    groupIdSelected = widget.initialGroupIdSelected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ArbEditorBloc>().state;

    final groups = Map.fromEntries([
      const MapEntry('', 'Nessun Gruppo'),
      ...state.document.groups.entries,
    ]);

    return Center(
      child: MainCard(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: [
                Expanded(
                  child: CardHeader(
                    title: 'Filtra',
                    onBack: () => Navigator.of(context).pop(),
                  ),
                ),
                IconButton(
                  onPressed: () => setState(() => groupIdSelected = {}),
                  icon: const Icon(Icons.close),
                  tooltip: "Resetta filtri",
                )
              ],
            ),
            const SizedBox(height: 20),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: groups.length,
              itemBuilder: (context, index) {
                final groupEntry = groups.entries.elementAt(index);

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(groupEntry.value),
                    Checkbox(
                      value: groupIdSelected.contains(groupEntry.key),
                      onChanged: (checked) => setState(() {
                        if (checked == true) {
                          groupIdSelected.add(groupEntry.key);
                        } else {
                          groupIdSelected.remove(groupEntry.key);
                        }
                      }),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 15),
            PrimaryButton(
              onPressed: () => Navigator.pop(context, groupIdSelected.toList()),
              label: 'Salva',
            ),
          ],
        ),
      ),
    );
  }
}
