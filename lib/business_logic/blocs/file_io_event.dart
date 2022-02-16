part of 'file_io_bloc.dart';

abstract class FileIOEvent extends Equatable {
  const FileIOEvent();
}

class FileIOLoaded extends FileIOEvent {
  @override
  List<Object?> get props => [];
}

class FileIOLoadedFromDragAndDrop extends FileIOEvent {
  @override
  List<Object?> get props => [];
}

class FileIOSaved extends FileIOEvent {
  @override
  List<Object?> get props => [];
}
