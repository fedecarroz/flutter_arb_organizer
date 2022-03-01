part of 'editor_menu_bloc.dart';

abstract class EditorMenuState extends Equatable {
  final ArbDocument arbDoc;
  final String pageName;

  const EditorMenuState(this.arbDoc, this.pageName);

  @override
  List<Object> get props => [arbDoc, pageName];
}

class EditorMainMenuState extends EditorMenuState {
  const EditorMainMenuState(
    ArbDocument arbDoc,
    String pageName,
  ) : super(arbDoc, pageName);
}

class EditorAllEntriesMenuState extends EditorMenuState {
  const EditorAllEntriesMenuState(
    ArbDocument arbDoc,
    String pageName,
  ) : super(arbDoc, pageName);
}

class EditorGroupMenuState extends EditorMenuState {
  const EditorGroupMenuState(
    ArbDocument arbDoc,
    String pageName,
  ) : super(arbDoc, pageName);
}

class EditorLanguageMenuState extends EditorMenuState {
  const EditorLanguageMenuState(
    ArbDocument arbDoc,
    String pageName,
  ) : super(arbDoc, pageName);
}
