import 'dart:io';
import 'dart:typed_data';

abstract class IOApiInterface {
  void saveArbFile();

  Future<List<File>> readFilesFromPicker({List<String>? extensionsAllowed});

  Future<void> saveArbFiles(
    Map<String, Uint8List> files, [
    String? defaultFileName,
  ]);

  Future<void> saveArbDocument(String filename, Uint8List content);
}
