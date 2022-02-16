part of 'arb_editor_bloc.dart';

abstract class ArbEditorState extends Equatable {
  const ArbEditorState();
}

class ArbEditorInitial extends ArbEditorState {
  @override
  List<Object> get props => [];
}
