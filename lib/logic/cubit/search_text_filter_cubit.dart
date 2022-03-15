import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'search_text_filter_state.dart';

class FilterCubit extends Cubit<FilterState> {
  FilterCubit() : super(FilterState.empty);

  void reset() => emit(FilterState.empty);

  void changeText(String text) => emit(state.copyWith(text: text));

  void changeFilters(List<String> groupIdsSelected) => emit(
        state.copyWith(groupIdsSelected: [...groupIdsSelected]),
      );
}
