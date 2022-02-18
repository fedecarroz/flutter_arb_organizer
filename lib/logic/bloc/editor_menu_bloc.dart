import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'editor_menu_event.dart';
part 'editor_menu_state.dart';

class EditorMenuBloc extends Bloc<EditorMenuEvent, EditorMenuState> {
  EditorMenuBloc() : super(const EditorMainMenuState('')) {
    on<MainMenuClicked>(_manageMainMenuClicked);
    on<AllEntriesMenuClicked>(_manageAllEntriesMenuClicked);
    on<GroupMenuClicked>(_manageGroupMenuClicked);
    on<LanguageMenuClicked>(_manageLanguageMenuClicked);
  }

  void _manageMainMenuClicked(
    MainMenuClicked event,
    Emitter<EditorMenuState> emit,
  ) =>
      emit(EditorMainMenuState(event.title));

  void _manageAllEntriesMenuClicked(
    AllEntriesMenuClicked event,
    Emitter<EditorMenuState> emit,
  ) =>
      emit(EditorAllEntriesMenuState(event.title));

  void _manageGroupMenuClicked(
    GroupMenuClicked event,
    Emitter<EditorMenuState> emit,
  ) =>
      emit(EditorGroupMenuState(event.title));

  void _manageLanguageMenuClicked(
    LanguageMenuClicked event,
    Emitter<EditorMenuState> emit,
  ) =>
      emit(EditorLanguageMenuState(event.title));
}
