import 'dart:convert';

import 'package:flutter_arb_organizer/data.dart';

class ArbDocument {
  final List<ArbLanguage> languages;
  final List<ArbEntriesGroups> groups;
  final String mainLanguage;

  ArbDocument({
    required this.mainLanguage,
    this.languages = const <ArbLanguage>[],
    this.groups = const <ArbEntriesGroups>[],
  });

  ArbDocument.fromJson(Map<String, dynamic> json)
      : this(
          mainLanguage: json['mainLanguage'] ?? LanguagesSupported.itIT,
          languages: List.from(json['languages'] ?? [])
              .map((l) => ArbLanguage.fromJson(l))
              .toList(),
          groups: List.from(json['groups'] ?? [])
              .map((g) => ArbEntriesGroups.fromJson(g))
              .toList(),
        );

  ArbDocument copyWith({
    String? mainLanguage,
    List<ArbLanguage>? languages,
    List<ArbEntriesGroups>? groups,
  }) {
    return ArbDocument(
      mainLanguage: mainLanguage ?? this.mainLanguage,
      languages: languages ?? this.languages,
      groups: groups ?? this.groups,
    );
  }

  Map<String, String> toArbFiles() {
    final arbFileMap = <String, String>{};

    for (final arbLang in languages) {
      final filename = "app_${arbLang.lang}.arb";
      final fileContent = jsonEncode(arbLang.entries);

      arbFileMap[filename] = fileContent;
    }

    return arbFileMap;
  }

  Map<String, dynamic> toJson() {
    return {
      'mainLanguage': mainLanguage,
      'groups': groups.map((g) => g.toJson()).toList(),
      'languages': languages.map((l) => l.toJson()).toList(),
    };
  }
}

class ArbLanguage {
  final String lang;
  final Map<String, String> entries;

  ArbLanguage({required this.lang, required this.entries});

  ArbLanguage.fromJson(Map<String, dynamic> json)
      : this(
          lang: json['lang'],
          entries: Map<String, String>.from(json['entries'] ?? {}),
        );

  ArbLanguage copyWith({
    String? lang,
    Map<String, String>? entries,
  }) {
    return ArbLanguage(
      lang: lang ?? this.lang,
      entries: entries ?? this.entries,
    );
  }

  Map<String, dynamic> toJson() => {
        'lang': lang,
        'entries': entries,
      };
}

class ArbEntriesGroups {
  final String name;
  final List<String> keys;

  ArbEntriesGroups({required this.name, required this.keys});

  ArbEntriesGroups.fromJson(Map<String, dynamic> json)
      : this(
          name: json['name'] ?? '',
          keys: List<String>.from(json['keys'] ?? []),
        );

  ArbEntriesGroups copyWith({
    String? name,
    List<String>? keys,
  }) {
    return ArbEntriesGroups(
      name: name ?? this.name,
      keys: keys ?? this.keys,
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'keys': keys,
      };
}
