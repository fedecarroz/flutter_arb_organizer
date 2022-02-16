part of 'arb_editor_bloc.dart';

abstract class ArbEditorEvent extends Equatable {
  const ArbEditorEvent();
}

class ArbEditorDocumentLoaded extends ArbEditorEvent {
  final ArbDocument arbDocument;

  const ArbEditorDocumentLoaded(this.arbDocument);

  @override
  List<Object?> get props => [arbDocument];
}

class ArbEditorEntryAdded extends ArbEditorEvent {
  final String entryKey;

  const ArbEditorEntryAdded(this.entryKey);

  @override
  List<Object?> get props => [entryKey];
}

class ArbEditorEntryUpdated extends ArbEditorEvent {
  final String entryKey;
  final String lang;
  final String value;

  const ArbEditorEntryUpdated(this.entryKey, this.lang, this.value);

  @override
  List<Object?> get props => [entryKey, lang, value];
}

class ArbEditorGroupCreated extends ArbEditorEvent {
  final String groupName;

  const ArbEditorGroupCreated(this.groupName);

  @override
  List<Object?> get props => [groupName];
}

class ArbEditorGroupEntryUpdated extends ArbEditorEvent {
  final String groupName;
  final String entryKey;

  const ArbEditorGroupEntryUpdated(this.groupName, this.entryKey);

  @override
  List<Object?> get props => [groupName, entryKey];
}
