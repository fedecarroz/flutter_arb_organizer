part of 'arb_editor_bloc.dart';

abstract class ArbEditorEvent extends Equatable {
  const ArbEditorEvent();

  @override
  List<Object?> get props => [];
}

class ArbEditorEntryAdded extends ArbEditorEvent {
  final ArbEntry arbEntry;

  const ArbEditorEntryAdded(this.arbEntry);

  @override
  List<Object?> get props => [arbEntry];
}

class ArbEditorEntryUpdated extends ArbEditorEvent {
  final ArbEntry arbEntry;

  const ArbEditorEntryUpdated(this.arbEntry);

  @override
  List<Object?> get props => [arbEntry];
}

class ArbEditorEntryRemoved extends ArbEditorEvent {
  final String entryKey;

  const ArbEditorEntryRemoved(this.entryKey);

  @override
  List<Object?> get props => [entryKey];
}

class ArbEditorGroupCreated extends ArbEditorEvent {
  final String groupName;

  const ArbEditorGroupCreated(this.groupName);

  @override
  List<Object?> get props => [groupName];
}

class ArbEditorGroupNameUpdated extends ArbEditorEvent {
  final String groupId;
  final String groupName;

  const ArbEditorGroupNameUpdated({
    required this.groupId,
    required this.groupName,
  });

  @override
  List<Object?> get props => [groupId, groupName];
}

class ArbEditorGroupEntryAdded extends ArbEditorEvent {
  final String groupId;
  final String entryKey;

  const ArbEditorGroupEntryAdded({
    required this.groupId,
    required this.entryKey,
  });

  @override
  List<Object?> get props => [groupId, entryKey];
}

class ArbEditorGroupRemoved extends ArbEditorEvent {
  final String groupId;
  final bool removeEntries;

  const ArbEditorGroupRemoved({
    required this.groupId,
    required this.removeEntries,
  });

  @override
  List<Object?> get props => [groupId];
}

class ArbEditorLanguageAdded extends ArbEditorEvent {
  final String lang;

  const ArbEditorLanguageAdded(this.lang);

  @override
  List<Object?> get props => [lang];
}

class ArbEditorLanguageUpdated extends ArbEditorEvent {
  final String lang;

  const ArbEditorLanguageUpdated(this.lang);

  @override
  List<Object?> get props => [lang];
}

class ArbEditorLanguageRemoved extends ArbEditorEvent {
  final String lang;

  const ArbEditorLanguageRemoved(this.lang);

  @override
  List<Object?> get props => [lang];
}