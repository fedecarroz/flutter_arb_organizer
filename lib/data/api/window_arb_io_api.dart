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
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions:
          extensionsAllowed ?? [FilesSupported.arbdoc, FilesSupported.arb],
    );

    if (result != null) {
      return result.files.map((f) => File(f.path!)).toList();
    } else {
      return [];
    }
  }

  @override
  saveArbFile() {}

  @override
  Future<void> saveArbDocument(String filename, Uint8List content) async {
    final arbDocPahth = GlobalConfiguration().arbDocumentPath;

    final fileSavePath = arbDocPahth ??
        await FilePicker.platform.saveFile(
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

      zipEncoder.addFile(
        ArchiveFile(filename, fileContent.length, fileContent),
      );
    }

    zipEncoder.endEncode();
    fileStream.close();
  }
}
