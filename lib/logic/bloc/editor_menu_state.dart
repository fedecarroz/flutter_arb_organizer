part of 'editor_menu_bloc.dart';

abstract class EditorMenuState extends Equatable {
  final String pageName;

  const EditorMenuState(this.pageName);

  @override
  List<Object> get props => [pageName];
}

class EditorMainMenuState extends EditorMenuState {
  const EditorMainMenuState(String pageName) : super(pageName);
}

class EditorAllEntriesMenuState extends EditorMenuState {
  const EditorAllEntriesMenuState(String pageName) : super(pageName);
}

class EditorGroupMenuState extends EditorMenuState {
  const EditorGroupMenuState(String pageName) : super(pageName);
}

class EditorLanguageMenuState extends EditorMenuState {
  const EditorLanguageMenuState(String pageName) : super(pageName);
}
