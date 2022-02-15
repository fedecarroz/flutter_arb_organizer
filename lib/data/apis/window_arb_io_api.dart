import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_arb_organizer/data/apis/arb_io_api.dart';

class WindowArbIOApi extends ArbIOApi {
  @override
  Future<List<File>> readArbFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
    );

    if (result != null) {
      return result.files.map((f) => File(f.path!)).toList();
    } else {
      return [];
    }
  }

  @override
  saveArbFile() {}
}
