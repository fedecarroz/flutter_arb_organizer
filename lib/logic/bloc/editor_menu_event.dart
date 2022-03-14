part of 'editor_menu_bloc.dart';

abstract class EditorMenuEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AllEntriesMenuClicked extends EditorMenuEvent {}

class GroupMenuClicked extends EditorMenuEvent {}

class GroupMenuAddClicked extends EditorMenuEvent {}

class GroupMenuUpdateClicked extends EditorMenuEvent {}

class GroupMenuRemoveClicked extends EditorMenuEvent {}

class LanguageMenuClicked extends EditorMenuEvent {}

class LanguageMenuAddClicked extends EditorMenuEvent {}

class LanguageMenuUpdateClicked extends EditorMenuEvent {
  final String currentLang;

  LanguageMenuUpdateClicked(this.currentLang);

  @override
  List<Object> get props => [currentLang];
}

class LanguageMenuRemoveClicked extends EditorMenuEvent {
  final String lang;

  LanguageMenuRemoveClicked(this.lang);

  @override
  List<Object> get props => [lang];
}
