class ArbFile {
  final String lang;
  final Map<String, String> entries;

  ArbFile({required this.lang, required this.entries});

  ArbFile copyWith({
    String? lang,
    Map<String, String>? entries,
  }) {
    return ArbFile(
      lang: lang ?? this.lang,
      entries: entries ?? this.entries,
    );
  }
}
