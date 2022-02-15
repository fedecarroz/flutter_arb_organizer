import 'dart:convert';
import 'dart:io';

import 'package:flutter_arb_organizer/data/apis/arb_io_api.dart';
import 'package:flutter_arb_organizer/data/apis/window_arb_io_api.dart';
import 'package:flutter_arb_organizer/data/models/arb_document.dart';

class ArbIORepository {
  final ArbIOApi arbIOApi;

  ArbIORepository() : arbIOApi = WindowArbIOApi();

  void readFiles() async {
    List<File> files = await arbIOApi.readArbFiles();
    ArbDocument? arbDoc;

    if (files.any((f) => f.path.endsWith('.arb'))) {
      final arbFiles = files.where((f) => f.path.endsWith('.arb')).toList();
      arbDoc = convertArbFilesToArbDocument(arbFiles);
    } else if (files.any((f) => f.path.endsWith('.arbdoc'))) {
      final arbDocFile = files.firstWhere((f) => f.path.endsWith('.arbdoc'));
      arbDoc = readArbDocument(arbDocFile);
    }
    print(arbDoc);
  }

  ArbDocument convertArbFilesToArbDocument(List<File> arbFiles) {
    final arbLanguages = <ArbLanguage>[];

    for (final arb in arbFiles) {
      final filename = arb.uri.pathSegments.last;
      final lang = filename.replaceAll(RegExp(r'(app_)|(.arb)'), '');
      final arbJson = readArb(arb);

      arbLanguages.add(ArbLanguage(lang: lang, entries: arbJson));
    }

    return ArbDocument(languages: arbLanguages, groups: []);
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
}
