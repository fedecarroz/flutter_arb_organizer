class ArbDocument {
  final List<ArbLanguage> languages;
  final List<ArbEntriesGroups> groups;

  ArbDocument({required this.languages, required this.groups});

  ArbDocument.fromJson(Map<String, dynamic> json)
      : this(
          languages: List.from(json['languages'] ?? [])
              .map((l) => ArbLanguage.fromJson(l))
              .toList(),
          groups: List.from(json['groups'] ?? [])
              .map((g) => ArbEntriesGroups.fromJson(g))
              .toList(),
        );
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
}
