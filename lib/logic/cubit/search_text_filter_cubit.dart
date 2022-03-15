import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'search_text_filter_state.dart';

class SearchTextFilterCubit extends Cubit<SearchTextFilterState> {
  SearchTextFilterCubit() : super(const SearchTextFilterState(''));

  void reset() => emit(const SearchTextFilterState(''));
  void changeText(String text) => emit(SearchTextFilterState(text));
}
