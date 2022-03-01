part of 'arb_editor_bloc.dart';

abstract class ArbEditorState extends Equatable {
  final ArbDocument document;

  const ArbEditorState(this.document);

  @override
  List<Object> get props => [document];
}

class ArbEditorInitial extends ArbEditorState {
  const ArbEditorInitial(ArbDocument document) : super(document);
}

class ArbEditorDocumentUpdateInProgress extends ArbEditorState {
  const ArbEditorDocumentUpdateInProgress(ArbDocument document)
      : super(document);
}

class ArbEditorDocumentUpdateSuccess extends ArbEditorState {
  const ArbEditorDocumentUpdateSuccess(ArbDocument document) : super(document);
}

class ArbEditorDocumentUpdateFailure extends ArbEditorState {
  const ArbEditorDocumentUpdateFailure(ArbDocument document) : super(document);
}