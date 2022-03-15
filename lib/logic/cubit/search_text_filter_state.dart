part of 'search_text_filter_cubit.dart';

class FilterState extends Equatable {
  final String text;
  final List<String> groupIdsSelected;

  static FilterState get empty => const FilterState(
        text: '',
        groupIdsSelected: [],
      );

  const FilterState({
    required this.text,
    required this.groupIdsSelected,
  });

  FilterState copyWith({
    String? text,
    List<String>? groupIdsSelected,
  }) {
    return FilterState(
      text: text ?? this.text,
      groupIdsSelected: groupIdsSelected ?? this.groupIdsSelected,
    );
  }

  @override
  List<Object?> get props => [text, groupIdsSelected];
}
