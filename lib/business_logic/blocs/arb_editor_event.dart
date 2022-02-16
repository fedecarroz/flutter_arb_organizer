part of 'arb_editor_bloc.dart';

abstract class ArbEditorEvent extends Equatable {
  const ArbEditorEvent();
}

class ArbEditorDocumentLoaded extends ArbEditorEvent {
  @override
  List<Object?> get props => [];
}

class ArbEditorEntryAdded extends ArbEditorEvent {
  @override
  List<Object?> get props => [];
}

class ArbEditorEntryUpdated extends ArbEditorEvent {
  @override
  List<Object?> get props => [];
}

class ArbEditorGroupCreated extends ArbEditorEvent {
  @override
  List<Object?> get props => [];
}

class ArbEditorGroupEntryUpdated extends ArbEditorEvent {
  @override
  List<Object?> get props => [];
}
