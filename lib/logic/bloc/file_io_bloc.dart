import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cross_file/cross_file.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_arb_organizer/data/repo/arb_io_repository.dart';

part 'file_io_event.dart';
part 'file_io_state.dart';

class FileIOBloc extends Bloc<FileIOEvent, FileIOState> {
  final _ioRepo = IORepository();

  FileIOBloc() : super(FileIOInitial()) {
    on<FileIOLoadStarted>(_manageFileLoad);
    on<FileIODropped>(_manageFileDrop);
  }

  void _manageFileLoad(
    FileIOLoadStarted event,
    Emitter<FileIOState> emit,
  ) async {
    emit(FileIOLoadPenging());

    final filesParsed = await _ioRepo.readFiles();

    emit(FileIOLoadComplete(filesParsed));
  }

  void _manageFileDrop(
    FileIODropped event,
    Emitter<FileIOState> emit,
  ) async {
    emit(FileIOLoadPenging());

    final files = event.files.map((f) => File(f.path));
    final filesParsed = await _ioRepo.readFiles(files);

    emit(FileIOLoadComplete(filesParsed));
  }
}
