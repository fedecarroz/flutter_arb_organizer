part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {}

class HomeResetted extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class HomeCreateInitialized extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class HomeDocumentLaunched extends HomeEvent {
  final ArbDocument arbDocument;

  HomeDocumentLaunched(this.arbDocument);

  @override
  List<Object?> get props => [arbDocument];
}
