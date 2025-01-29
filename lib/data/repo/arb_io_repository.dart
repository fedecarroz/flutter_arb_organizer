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
        final arbFile = parseArbLanguageDocument(file);
        filesParsed.add(arbFile);
      } else if (file.path.endsWith('.${FilesSupported.arbdoc}')) {
        final arbDoc = readArbDocument(file);
        filesParsed.add(arbDoc);
        GlobalConfiguration().copyWith(arbDocumentPath: file.path);
        break;
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
    final json = jsonDecode(fileContent);
    return ArbDocument.fromMap(json);
  }

  Map<String, String> readArb(File file) {
    final fileContent = utf8.decode(file.readAsBytesSync());
    final json = Map<String, dynamic>.from(jsonDecode(fileContent));

    json.removeWhere((String key, _) => key.startsWith('@'));

    return Map<String, String>.from(json).map((key, value) {
      final newValue = value.replaceAll('\n', '\\n');
      return MapEntry(key, newValue);
    });
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
        final arbContentText =
            jsonEncode(arbContentMap).replaceAll("\\\\", '\\');
        final arbContent = Uint8List.fromList(utf8.encode(arbContentText));

        final langReduced = "app_${lang.split('_').first}.arb";

        return MapEntry(langReduced, arbContent);
      });
      final filename = document.projectName.toLowerCase().replaceAll(' ', '_');
      _ioApi.saveArbFiles(Map.fromEntries(arbFiles), '${filename}_arbs.zip');

      return true;
    } on Exception {
      return false;
    }
  }

  Future<bool> saveDocument(ArbDocument document) async {
    try {
      final arbDocJson = document.toMap();
      final arbDocContent = utf8.encode(jsonEncode(arbDocJson));
      final arbBytes = Uint8List.fromList(arbDocContent);

      final filename = document.projectName.toLowerCase().replaceAll(' ', '_');
      _ioApi.saveArbDocument(filename, arbBytes);

      return true;
    } on Exception {
      return false;
    }
  }
}
