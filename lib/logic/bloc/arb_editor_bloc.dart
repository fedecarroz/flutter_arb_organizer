import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_arb_organizer/data.dart';

part 'arb_editor_event.dart';
part 'arb_editor_state.dart';

class ArbEditorBloc extends Bloc<ArbEditorEvent, ArbEditorState> {
  ArbEditorBloc(ArbDocument document) : super(ArbEditorInitial(document)) {
    on<ArbEditorEntryAdded>(_manageEntryAdded);
    on<ArbEditorEntryUpdated>(_manageEntryUpdated);
    on<ArbEditorEntryRemoved>(_manageEntryRemoved);
    on<ArbEditorGroupCreated>(_manageGroupCreated);
    on<ArbEditorGroupNameUpdated>(_manageGroupNameUpdated);
    on<ArbEditorGroupEntryAdded>(_manageGroupEntryAdded);
    on<ArbEditorGroupRemoved>(_manageGroupRemoved);
    on<ArbEditorLanguageAdded>(_manageLanguageAdded);
    on<ArbEditorLanguageUpdated>(_manageLanguageUpdated);
    on<ArbEditorLanguageRemoved>(_manageLanguageRemoved);
  }

  void _manageEntryAdded(
    ArbEditorEntryAdded event,
    Emitter<ArbEditorState> emit,
  ) {
    emit(ArbEditorDocumentUpdateInProgress(state.document));

    final labels = state.document.labels;

    final test = labels.putIfAbsent(
      event.arbEntry.key,
      () => event.arbEntry,
    );

    if (test == event.arbEntry) {
      emit(
        ArbEditorDocumentUpdateSuccess(
          state.document.copyWith(
            labels: labels,
          ),
        ),
      );
    } else {
      emit(ArbEditorDocumentUpdateFailure(state.document));
    }
  }

  //TODO: continuare implementazione
  void _manageEntryUpdated(
    ArbEditorEntryUpdated event,
    Emitter<ArbEditorState> emit,
  ) {}

  void _manageEntryRemoved(
    ArbEditorEntryRemoved event,
    Emitter<ArbEditorState> emit,
  ) {}

  void _manageGroupCreated(
    ArbEditorGroupCreated event,
    Emitter<ArbEditorState> emit,
  ) {}

  void _manageGroupNameUpdated(
    ArbEditorGroupNameUpdated event,
    Emitter<ArbEditorState> emit,
  ) {}

  void _manageGroupEntryAdded(
    ArbEditorGroupEntryAdded event,
    Emitter<ArbEditorState> emit,
  ) {}

  void _manageGroupRemoved(
    ArbEditorGroupRemoved event,
    Emitter<ArbEditorState> emit,
  ) {}

  void _manageLanguageAdded(
    ArbEditorLanguageAdded event,
    Emitter<ArbEditorState> emit,
  ) {}

  void _manageLanguageUpdated(
    ArbEditorLanguageUpdated event,
    Emitter<ArbEditorState> emit,
  ) {}

  void _manageLanguageRemoved(
    ArbEditorLanguageRemoved event,
    Emitter<ArbEditorState> emit,
  ) {}
}
