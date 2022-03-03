import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_arb_organizer/data.dart';

class IORepository {
  final IOApiInterface _ioApi;

  IORepository() : _ioApi = WindowArbIOApi();

  Future<List<Object>> readFiles({
    Iterable<File>? importedFiles,
    List<String>? extensionsAllowed,
  }) async {
    Iterable<File> files = importedFiles ??
        await _ioApi.readFilesFromPicker(
          extensionsAllowed: extensionsAllowed,
        );

    List<Object> filesParsed = [];

    for (final file in files) {
      if (file.path.endsWith('.${FilesSupported.arb}')) {
        final arbLanguage = parseArbLanguageDocument(file);
        filesParsed.add(arbLanguage);
      } else if (file.path.endsWith('.${FilesSupported.arbdoc}')) {
        final arbDoc = readArbDocument(file);
        filesParsed.add(arbDoc);
      }
    }

    return filesParsed;
  }

  ArbFile parseArbLanguageDocument(File arb) {
    final filename = arb.uri.pathSegments.last;
    final lang = filename.replaceAll(RegExp(r'(app_)|(.arb)'), '');
    final langNormalized = LanguagesSupported.values.firstWhere(
      (l) => l.startsWith(lang),
      orElse: () => '',
    );

    final arbJson = readArb(arb);

    return ArbFile(lang: langNormalized, entries: arbJson);
  }

  ArbDocument readArbDocument(File arbDocumentFile) {
    final fileContent = utf8.decode(arbDocumentFile.readAsBytesSync());
    return ArbDocument.fromJson(fileContent);
  }

  Map<String, String> readArb(File file) {
    final fileContent = utf8.decode(file.readAsBytesSync());
    final json = Map<String, dynamic>.from(jsonDecode(fileContent));

    json.removeWhere((String key, _) => key.startsWith('@'));
    return Map<String, String>.from(json);
  }

  Future<bool> saveArbs(ArbDocument document) async {
    try {
      final arbFiles = document.languages.map((lang) {
        final arbContentMap = document.labels.map(
          (id, entry) => MapEntry(
            entry.key,
            entry.localizedValues[lang] ?? '',
          ),
        );
        final arbContentText = jsonEncode(arbContentMap);
        final arbContent = Uint8List.fromList(utf8.encode(arbContentText));

        final langReduced = lang.split('_').first;

        return MapEntry(langReduced, arbContent);
      });

      _ioApi.saveMultipleFiles(Map.fromEntries(arbFiles), 'arbs.zip');

      return true;
    } on Exception {
      return false;
    }
  }

  Future<bool> saveDocument(ArbDocument document) async {
    try {
      final arbDocJson = document.toJson();
      final arbDocContent = utf8.encode(jsonEncode(arbDocJson));
      final arbBytes = Uint8List.fromList(arbDocContent);

      _ioApi.saveFile('document.arbdoc', arbBytes);
      return true;
    } on Exception {
      return false;
    }
  }
}
