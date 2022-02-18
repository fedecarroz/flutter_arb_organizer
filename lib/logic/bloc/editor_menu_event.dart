part of 'editor_menu_bloc.dart';

abstract class EditorMenuEvent extends Equatable {
  final String title;

  const EditorMenuEvent(this.title);

  @override
  List<Object> get props => [];
}

class MainMenuClicked extends EditorMenuEvent {
  const MainMenuClicked(String title) : super(title);
}

class AllEntriesMenuClicked extends EditorMenuEvent {
  const AllEntriesMenuClicked(String title) : super(title);
}

class GroupMenuClicked extends EditorMenuEvent {
  const GroupMenuClicked(String title) : super(title);
}

class LanguageMenuClicked extends EditorMenuEvent {
  const LanguageMenuClicked(String title) : super(title);
}
