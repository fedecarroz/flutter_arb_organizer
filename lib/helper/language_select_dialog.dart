import 'package:flutter/material.dart';
import 'package:flutter_arb_organizer/interface.dart';

Future<String?> showSingleLanguageSelectDialog(
  BuildContext context,
  List<String> languages, {
  String? dialogTitle,
}) async {
  final _dialogTitle = dialogTitle ?? 'Scegli la lingua principale';

  return showDialog<String?>(
    context: context,
    builder: (context) {
      return Center(
        child: LangSelectCard(
          languages: languages,
          title: _dialogTitle,
          onBackClick: () => Navigator.pop(context),
          onLanguageClick: (lang) => Navigator.pop(context, lang),
        ),
      );
    },
  );
}

Future<List<String>?> showLanguageSelectDialog(
  BuildContext context,
  List<String> languages, {
  List<String> langsToRemove = const [],
}) async {
  final langsToShow =
      languages.where((l) => !langsToRemove.contains(l)).toList();

  final languagesSelected = <String>{};

  return showDialog<List<String>?>(
    context: context,
    builder: (context) {
      return Center(
        child: MainCard.dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CardHeader(
                title: 'Scegli le lingue supportate',
                onBack: () => Navigator.pop(context),
              ),
              if (langsToShow.isEmpty)
                SizedBox(
                  height: 100,
                  child: Center(
                    child: Text(
                      'Nessuna lingua presente',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ),
                )
              else
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: StatefulBuilder(
                    builder: (context, StateSetter setState) {
                      return ConstrainedBox(
                        constraints: const BoxConstraints(maxHeight: 300),
                        child: ListView.builder(
                          physics: const ClampingScrollPhysics(),
                          itemCount: langsToShow.length,
                          itemBuilder: (context, i) {
                            final lang = languages[i];

                            return Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    lang,
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                Material(
                                  child: Checkbox(
                                    value: languagesSelected.contains(lang),
                                    onChanged: (checked) => setState(() {
                                      if (checked == true) {
                                        languagesSelected.add(lang);
                                      } else {
                                        languagesSelected.remove(lang);
                                      }
                                    }),
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              if (langsToShow.isNotEmpty)
                Row(
                  children: [
                    Flexible(
                      child: PrimaryButton(
                        label: 'Salva',
                        onPressed: () => Navigator.pop(
                          context,
                          List.of(languagesSelected),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Flexible(
                      child: SecondaryButton(
                        label: 'Chiudi',
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      );
    },
  );
}
