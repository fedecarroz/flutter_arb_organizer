part of 'file_io_bloc.dart';

abstract class FileIOState extends Equatable {
  const FileIOState();
}

class ArbIoInitial extends FileIOState {
  @override
  List<Object> get props => [];
}
