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
    on<GroupMenuAddClicked>(_manageGroupMenuAddClicked);
    on<GroupMenuUpdateClicked>(_manageGroupMenuUpdateClicked);
    on<GroupMenuRemoveClicked>(_manageGroupMenuRemoveClick);
    on<LanguageMenuClicked>(_manageLanguageMenuClicked);
    on<LanguageMenuAddClicked>(_manageLanguageMenuAddClicked);
    on<LanguageMenuUpdateClicked>(_manageLanguageMenuUpdateClicked);
    on<LanguageMenuRemoveClicked>(_manageLanguageMenuRemoveClick);
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

  void _manageGroupMenuAddClicked(
    GroupMenuAddClicked event,
    Emitter<EditorMenuState> emit,
  ) =>
      emit(const EditorGroupMenuAddStart('Gestione gruppi'));

  void _manageGroupMenuUpdateClicked(
    GroupMenuUpdateClicked event,
    Emitter<EditorMenuState> emit,
  ) =>
      emit(const EditorGroupMenuUpdateStart('Gestione gruppi'));

  void _manageGroupMenuRemoveClick(
    GroupMenuRemoveClicked event,
    Emitter<EditorMenuState> emit,
  ) =>
      emit(const EditorGroupMenuRemoveStart('Gestione gruppi'));

  void _manageLanguageMenuClicked(
    LanguageMenuClicked event,
    Emitter<EditorMenuState> emit,
  ) =>
      emit(const EditorLanguageMenuInitial('Lingue supportate'));

  void _manageLanguageMenuAddClicked(
    LanguageMenuAddClicked event,
    Emitter<EditorMenuState> emit,
  ) =>
      emit(const EditorLanguageMenuAddStart('Lingue supportate'));

  void _manageLanguageMenuUpdateClicked(
    LanguageMenuUpdateClicked event,
    Emitter<EditorMenuState> emit,
  ) =>
      emit(
        EditorLanguageMenuUpdateStart(
          'Lingue supportate',
          event.currentLang,
        ),
      );

  void _manageLanguageMenuRemoveClick(
    LanguageMenuRemoveClicked event,
    Emitter<EditorMenuState> emit,
  ) =>
      emit(
        EditorLanguageMenuRemoveStart(
          'Lingue supportate',
          event.lang,
        ),
      );
}
