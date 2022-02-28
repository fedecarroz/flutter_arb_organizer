import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_arb_organizer/data/models/arb_document.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeResetted>((event, emit) => emit(HomeInitial()));
    on<HomeCreateInitialized>((event, emit) => emit(HomeCreateFormInit()));
    on<HomeLanguagesImported>((event, emit) => emit(HomeLanguagesImport()));
    on<HomeDocumentImported>(
      (event, emit) => emit(HomeImportDocument(event.arbDocument)),
    );
  }
}
