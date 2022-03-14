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

class EditorGroupMenuInitial extends EditorGroupMenuState {
  const EditorGroupMenuInitial(String pageName) : super(pageName);
}

class EditorGroupMenuAddStart extends EditorGroupMenuState {
  const EditorGroupMenuAddStart(String pageName) : super(pageName);
}

class EditorGroupMenuUpdateStart extends EditorGroupMenuState {
  const EditorGroupMenuUpdateStart(String pageName) : super(pageName);
}

class EditorGroupMenuRemoveStart extends EditorGroupMenuState {
  const EditorGroupMenuRemoveStart(String pageName) : super(pageName);
}

abstract class EditorLanguageMenuState extends EditorMenuState {
  const EditorLanguageMenuState(String pageName) : super(pageName);
}

class EditorLanguageMenuInitial extends EditorLanguageMenuState {
  const EditorLanguageMenuInitial(String pageName) : super(pageName);
}

class EditorLanguageMenuAddStart extends EditorLanguageMenuState {
  const EditorLanguageMenuAddStart(String pageName) : super(pageName);
}

class EditorLanguageMenuUpdateStart extends EditorLanguageMenuState {
  final String currentLang;

  const EditorLanguageMenuUpdateStart(String pageName, this.currentLang)
      : super(pageName);
  @override
  List<Object> get props => [pageName, currentLang];
}

class EditorLanguageMenuRemoveStart extends EditorLanguageMenuState {
  final String lang;

  const EditorLanguageMenuRemoveStart(String pageName, this.lang)
      : super(pageName);
  @override
  List<Object> get props => [pageName, lang];
}
