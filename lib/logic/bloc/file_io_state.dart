part of 'file_io_bloc.dart';

abstract class FileIOState extends Equatable {
  const FileIOState();
}

class FileIOInitial extends FileIOState {
  @override
  List<Object> get props => [];
}

class FileIOLoadInProgress extends FileIOState {
  @override
  List<Object> get props => [];
}

class FileIOLoadComplete extends FileIOState {
  final List<Object> docs;

  const FileIOLoadComplete(this.docs);

  @override
  List<Object> get props => [docs];
}

class FileIOSaveInProgress extends FileIOState {
  @override
  List<Object> get props => [];
}

class FileIOSaveComplete extends FileIOState {
  @override
  List<Object> get props => [];
}

class FileIOSaveFailure extends FileIOState {
  @override
  List<Object> get props => [];
}
