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
  final String? newKey;

  const ArbEditorEntryUpdated(this.arbEntry, {this.newKey});

  @override
  List<Object?> get props => [arbEntry];
}

class ArbEditorEntryRemoved extends ArbEditorEvent {
  final ArbEntry arbEntry;

  const ArbEditorEntryRemoved(this.arbEntry);

  @override
  List<Object?> get props => [arbEntry];
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
  final ArbEntry arbEntry;

  const ArbEditorGroupEntryAdded({
    required this.groupId,
    required this.arbEntry,
  });

  @override
  List<Object?> get props => [groupId, arbEntry];
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
  final String oldLang;
  final String newLang;

  const ArbEditorLanguageUpdated({
    required this.oldLang,
    required this.newLang,
  });

  @override
  List<Object?> get props => [oldLang, newLang];
}

class ArbEditorLanguageRemoved extends ArbEditorEvent {
  final String lang;

  const ArbEditorLanguageRemoved(this.lang);

  @override
  List<Object?> get props => [lang];
}
