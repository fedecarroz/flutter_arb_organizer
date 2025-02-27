import 'dart:io';
import 'dart:typed_data';

import 'package:archive/archive_io.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_arb_organizer/data.dart';

class WindowArbIOApi extends IOApiInterface {
  @override
  Future<List<File>> readFilesFromPicker({
    List<String>? extensionsAllowed,
  }) async {
    final result = await FilePicker.platform.pickFiles(
      dialogTitle: 'Seleziona file',
      lockParentWindow: true,
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions:
          extensionsAllowed ?? [FilesSupported.arbdoc, FilesSupported.arb],
    );

    return result?.files.map((f) => File(f.path!)).toList() ?? [];
  }

  @override
  saveArbFile() {}

  @override
  Future<void> saveArbDocument(String filename, Uint8List content) async {
    final arbDocPahth = GlobalConfiguration().arbDocumentPath;

    final fileSavePath = arbDocPahth ??
        await FilePicker.platform.saveFile(
          dialogTitle: 'Salva documento',
          lockParentWindow: true,
          type: FileType.custom,
          allowedExtensions: ['arbdoc'],
          fileName: filename,
        );

    if (fileSavePath != null) {
      await File(fileSavePath).writeAsBytes(content);
      GlobalConfiguration().copyWith(arbDocumentPath: fileSavePath);
    }
  }

  @override
  Future<void> saveArbFiles(
    Map<String, Uint8List> files, [
    String? defaultFileName,
  ]) async {
    final zipEncoder = ZipEncoder();

    final fileSavePath = await FilePicker.platform.saveFile(
      dialogTitle: 'Salva archivio',
      lockParentWindow: true,
      type: FileType.custom,
      allowedExtensions: ['zip'],
      fileName: defaultFileName,
    );

    if (fileSavePath == null) return;

    final fileStream = OutputFileStream(fileSavePath);
    zipEncoder.startEncode(fileStream);

    for (final file in files.entries) {
      final filename = file.key;
      final fileContent = file.value;

      zipEncoder.add(
        ArchiveFile(filename, fileContent.length, fileContent),
      );
    }

    zipEncoder.endEncode();
    fileStream.close();
  }
}
