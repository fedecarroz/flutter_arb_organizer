part of 'file_io_bloc.dart';

abstract class FileIOEvent extends Equatable {
  const FileIOEvent();
}

class FileIOLoadStarted extends FileIOEvent {
  @override
  List<Object?> get props => [];
}

class FileIODropped extends FileIOEvent {
  final List<XFile> files;

  const FileIODropped(this.files);

  @override
  List<Object?> get props => [files];
}

class FileIOArbsSaved extends FileIOEvent {
  final ArbDocument document;

  const FileIOArbsSaved(this.document);

  @override
  List<Object?> get props => [document];
}

class FileIOArbDocSaved extends FileIOEvent {
  final ArbDocument document;

  const FileIOArbDocSaved(this.document);

  @override
  List<Object?> get props => [document];
}
