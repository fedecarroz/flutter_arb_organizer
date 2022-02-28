part of 'editor_menu_bloc.dart';

abstract class EditorMenuEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class MainMenuClicked extends EditorMenuEvent {}

class AllEntriesMenuClicked extends EditorMenuEvent {}

class GroupMenuClicked extends EditorMenuEvent {}

class LanguageMenuClicked extends EditorMenuEvent {}
