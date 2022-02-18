part of 'editor_menu_bloc.dart';

abstract class EditorMenuState extends Equatable {
  final String title;

  const EditorMenuState(this.title);

  @override
  List<Object> get props => [title];
}

class EditorMainMenuState extends EditorMenuState {
  const EditorMainMenuState(String title) : super(title);
}

class EditorAllEntriesMenuState extends EditorMenuState {
  const EditorAllEntriesMenuState(String title) : super(title);
}

class EditorGroupMenuState extends EditorMenuState {
  const EditorGroupMenuState(String title) : super(title);
}

class EditorLanguageMenuState extends EditorMenuState {
  const EditorLanguageMenuState(String title) : super(title);
}
