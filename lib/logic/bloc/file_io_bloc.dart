import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cross_file/cross_file.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_arb_organizer/data.dart';

part 'file_io_event.dart';
part 'file_io_state.dart';

class FileIOBloc extends Bloc<FileIOEvent, FileIOState> {
  final _ioRepo = IORepository();

  FileIOBloc() : super(FileIOInitial()) {
    on<FileIOLoadStarted>(_manageFileLoad);
    on<FileIODropped>(_manageFileDrop);
    on<FileIOArbsSaved>(_manageArbsSave);
    on<FileIOArbDocSaved>(_manageArbDocumentSave);
  }

  void _manageFileLoad(
    FileIOLoadStarted event,
    Emitter<FileIOState> emit,
  ) async {
    emit(FileIOLoadInProgress());

    final filesParsed = await _ioRepo.readFiles();

    emit(FileIOLoadComplete(filesParsed));
  }

  void _manageFileDrop(
    FileIODropped event,
    Emitter<FileIOState> emit,
  ) async {
    emit(FileIOLoadInProgress());

    final files = event.files.map((f) => File(f.path));
    final filesParsed = await _ioRepo.readFiles(importedFiles: files);

    emit(FileIOLoadComplete(filesParsed));
  }

  void _manageArbsSave(
    FileIOArbsSaved event,
    Emitter<FileIOState> emit,
  ) async {
    emit(FileIOSaveInProgress());

    await _ioRepo.saveArbs(event.document);
    try {
      emit(FileIOSaveComplete());
    } catch (e) {
      emit(FileIOSaveFailure());
    }
  }

  void _manageArbDocumentSave(
    FileIOArbDocSaved event,
    Emitter<FileIOState> emit,
  ) async {
    emit(FileIOSaveInProgress());

    await _ioRepo.saveDocument(event.document);
    try {
      emit(FileIOSaveComplete());
    } catch (e) {
      emit(FileIOSaveFailure());
    }
  }
}
