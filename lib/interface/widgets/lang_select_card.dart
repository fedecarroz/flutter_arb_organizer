import 'package:flutter/material.dart';
import 'package:flutter_arb_organizer/interface.dart';

class LangSelectCard extends StatelessWidget {
  final Function()? onBackClick;
  final Function(String lang)? onLanguageClick;
  final String title;
  final List<String> languages;

  const LangSelectCard({
    Key? key,
    this.onBackClick,
    this.onLanguageClick,
    this.title = '',
    this.languages = const <String>[],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainCard.dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CardHeader(
            title: title,
            onBack: onBackClick,
          ),
          if (languages.isEmpty)
            SizedBox(
              height: 100,
              child: Center(
                child: Text(
                  'Nessuna lingua supportata presente',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ),
            )
          else
            const SizedBox(height: 15),
          for (final lang in languages) ...[
            InkWell(
              onTap: () => onLanguageClick?.call(lang),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Text(
                  lang,
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ),
            ),
          ]
        ],
      ),
    );
  }
}
