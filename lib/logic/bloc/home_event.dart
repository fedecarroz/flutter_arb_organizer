part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeResetted extends HomeEvent {}

class HomeCreateInitialized extends HomeEvent {}

class HomeLanguagesImported extends HomeEvent {}

class HomeDocumentImported extends HomeEvent {
  final ArbDocument arbDocument;

  HomeDocumentImported(this.arbDocument);

  @override
  List<Object?> get props => [arbDocument];
}
