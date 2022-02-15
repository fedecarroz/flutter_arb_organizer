import 'dart:io';

abstract class ArbIOApi {
  void saveArbFile();

  Future<List<File>> readArbFiles();
}
