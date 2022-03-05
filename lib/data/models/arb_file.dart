import 'package:equatable/equatable.dart';

class ArbFile extends Equatable {
  final String lang;
  final Map<String, String> entries;

  const ArbFile({required this.lang, required this.entries});

  ArbFile copyWith({
    String? lang,
    Map<String, String>? entries,
  }) {
    return ArbFile(
      lang: lang ?? this.lang,
      entries: entries ?? this.entries,
    );
  }

  @override
  List<Object?> get props => [lang, entries];
}
