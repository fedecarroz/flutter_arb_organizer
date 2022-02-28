part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeCreateFormInit extends HomeState {}

class HomeLanguagesImport extends HomeState {}

class HomeImportDocument extends HomeState {
  final ArbDocument arbDocument;

  HomeImportDocument(this.arbDocument);

  @override
  List<Object?> get props => [arbDocument];
}
