import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_arb_organizer/helper/data.dart';

class IORepository {
  final IOApiInterface _ioApi;

  IORepository() : _ioApi = WindowArbIOApi();

  Future<ArbDocument> readFiles() async {
    List<File> files = await _ioApi.readArbFiles();
    ArbDocument? arbDoc;

    if (files.any((f) => f.path.endsWith('.arb'))) {
      final arbFiles = files.where((f) => f.path.endsWith('.arb')).toList();
      arbDoc = convertArbFilesToArbDocument(arbFiles);

      return arbDoc;
    } else if (files.any((f) => f.path.endsWith('.arbdoc'))) {
      final arbDocFile = files.firstWhere((f) => f.path.endsWith('.arbdoc'));
      arbDoc = readArbDocument(arbDocFile);
      return arbDoc;
    } else if (files.isEmpty) {
      throw Exception('Files not selected');
    } else {
      throw Exception('Files not Supported');
    }
  }

  ArbDocument convertArbFilesToArbDocument(List<File> arbFiles) {
    final arbLanguages = <ArbLanguage>[];

    for (final arb in arbFiles) {
      final filename = arb.uri.pathSegments.last;
      final lang = filename.replaceAll(RegExp(r'(app_)|(.arb)'), '');
      final arbJson = readArb(arb);

      arbLanguages.add(ArbLanguage(lang: lang, entries: arbJson));
    }

    return ArbDocument(
      languages: arbLanguages,
      groups: [],
      mainLanguage: LanguagesSupported.it,
    );
  }

  ArbDocument readArbDocument(File arbDocumentFile) {
    final fileContent = utf8.decode(arbDocumentFile.readAsBytesSync());
    final json = jsonDecode(fileContent);

    final arbDocJson = Map<String, String>.from(json);

    return ArbDocument.fromJson(arbDocJson);
  }

  Map<String, String> readArb(File file) {
    final fileContent = utf8.decode(file.readAsBytesSync());
    final json = jsonDecode(fileContent);

    return Map<String, String>.from(json);
  }

  Future<bool> saveArbs(ArbDocument document) async {
    try {
      final arbFiles = document.toArbFiles().map((key, value) {
        final bytes = utf8.encode(value);
        return MapEntry(key, Uint8List.fromList(bytes));
      });

      _ioApi.saveMultipleFiles(arbFiles, 'arbs.zip');

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
