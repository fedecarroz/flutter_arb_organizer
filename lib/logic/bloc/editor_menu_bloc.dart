import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_arb_organizer/data/models/arb_document.dart';

part 'editor_menu_event.dart';
part 'editor_menu_state.dart';

class EditorMenuBloc extends Bloc<EditorMenuEvent, EditorMenuState> {
  EditorMenuBloc(ArbDocument arbDoc)
      : super(EditorMainMenuState(arbDoc, arbDoc.projectName)) {
    on<MainMenuClicked>(_manageMainMenuClicked);
    on<AllEntriesMenuClicked>(_manageAllEntriesMenuClicked);
    on<GroupMenuClicked>(_manageGroupMenuClicked);
    on<LanguageMenuClicked>(_manageLanguageMenuClicked);
  }

  void _manageMainMenuClicked(
    MainMenuClicked event,
    Emitter<EditorMenuState> emit,
  ) =>
      emit(EditorMainMenuState(state.arbDoc, state.arbDoc.projectName));

  void _manageAllEntriesMenuClicked(
    AllEntriesMenuClicked event,
    Emitter<EditorMenuState> emit,
  ) =>
      emit(
          EditorAllEntriesMenuState(state.arbDoc, 'Etichette e info progetto'));

  void _manageGroupMenuClicked(
    GroupMenuClicked event,
    Emitter<EditorMenuState> emit,
  ) =>
      emit(EditorGroupMenuState(state.arbDoc, 'Gestione gruppi'));

  void _manageLanguageMenuClicked(
    LanguageMenuClicked event,
    Emitter<EditorMenuState> emit,
  ) =>
      emit(EditorLanguageMenuState(state.arbDoc, 'Lingue supportate'));
}
