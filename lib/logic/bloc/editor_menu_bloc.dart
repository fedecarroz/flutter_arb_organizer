import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'editor_menu_event.dart';
part 'editor_menu_state.dart';

class EditorMenuBloc extends Bloc<EditorMenuEvent, EditorMenuState> {
  final String projectName;

  EditorMenuBloc(this.projectName) : super(EditorMainMenuState(projectName)) {
    on<MainMenuClicked>(_manageMainMenuClicked);
    on<AllEntriesMenuClicked>(_manageAllEntriesMenuClicked);
    on<GroupMenuClicked>(_manageGroupMenuClicked);
    on<LanguageMenuClicked>(_manageLanguageMenuClicked);
  }

  void _manageMainMenuClicked(
    MainMenuClicked event,
    Emitter<EditorMenuState> emit,
  ) =>
      emit(EditorMainMenuState(projectName));

  void _manageAllEntriesMenuClicked(
    AllEntriesMenuClicked event,
    Emitter<EditorMenuState> emit,
  ) =>
      emit(const EditorAllEntriesMenuState('Etichette e info progetto'));

  void _manageGroupMenuClicked(
    GroupMenuClicked event,
    Emitter<EditorMenuState> emit,
  ) =>
      emit(const EditorGroupMenuState('Gestione gruppi'));

  void _manageLanguageMenuClicked(
    LanguageMenuClicked event,
    Emitter<EditorMenuState> emit,
  ) =>
      emit(const EditorLanguageMenuState('Lingue supportate'));
}
