part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeCreateFormInitComplete extends HomeState {}

class HomeLaunchDocumentComplete extends HomeState {
  final ArbDocument arbDocument;

  HomeLaunchDocumentComplete(this.arbDocument);

  @override
  List<Object?> get props => [arbDocument];
}
