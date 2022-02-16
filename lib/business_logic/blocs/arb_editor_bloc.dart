import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_arb_organizer/helper/data.dart';

part 'arb_editor_event.dart';
part 'arb_editor_state.dart';

class ArbEditorBloc extends Bloc<ArbEditorEvent, ArbEditorState> {
  ArbEditorBloc() : super(ArbEditorInitial()) {
    on<ArbEditorEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
