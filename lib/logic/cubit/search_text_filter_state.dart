part of 'search_text_filter_cubit.dart';

class SearchTextFilterState extends Equatable {
  final String text;

  const SearchTextFilterState(this.text);

  @override
  List<Object?> get props => [text];
}
