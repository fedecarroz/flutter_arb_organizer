import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'file_io_event.dart';
part 'file_io_state.dart';

class ArbIoBloc extends Bloc<FileIOEvent, ArbIoState> {
  ArbIoBloc() : super(ArbIoInitial()) {
    on<FileIOEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
