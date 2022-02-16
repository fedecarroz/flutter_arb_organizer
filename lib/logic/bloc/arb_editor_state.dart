part of 'arb_editor_bloc.dart';

abstract class ArbEditorState extends Equatable {
  final ArbDocument document;

  const ArbEditorState(this.document);

  @override
  List<Object> get props => [document];
}

class ArbEditorInitial extends ArbEditorState {
  ArbEditorInitial() : super(ArbDocument());
}

class ArbEditorDocumentLoadSuccess extends ArbEditorState {
  const ArbEditorDocumentLoadSuccess(ArbDocument document) : super(document);
}

class ArbEditorDocumentUpdateSuccess extends ArbEditorState {
  const ArbEditorDocumentUpdateSuccess(ArbDocument document) : super(document);
}
