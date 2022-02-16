class ArbDocument {
  final List<ArbLanguage> languages;
  final List<ArbEntriesGroups> groups;

  ArbDocument({
    this.languages = const <ArbLanguage>[],
    this.groups = const <ArbEntriesGroups>[],
  });

  ArbDocument.fromJson(Map<String, dynamic> json)
      : this(
          languages: List.from(json['languages'] ?? [])
              .map((l) => ArbLanguage.fromJson(l))
              .toList(),
          groups: List.from(json['groups'] ?? [])
              .map((g) => ArbEntriesGroups.fromJson(g))
              .toList(),
        );

  ArbDocument copyWith({
    List<ArbLanguage>? languages,
    List<ArbEntriesGroups>? groups,
  }) {
    return ArbDocument(
      languages: languages ?? this.languages,
      groups: groups ?? this.groups,
    );
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
}
