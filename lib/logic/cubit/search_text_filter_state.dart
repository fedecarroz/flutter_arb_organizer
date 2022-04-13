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

  Map<String, ArbEntry> filterLabels(Map<String, ArbEntry> input) {
    var output = Map.of(input).entries;

    if (text.isNotEmpty) {
      output = output.where((entry) => entry.key.startsWith(text));
    }

    if (groupIdsSelected.isNotEmpty) {
      output = output.where(
        (entry) => groupIdsSelected.contains(entry.value.groupId),
      );
    }

    output = output.toList()..sort((p, n) => p.key.compareTo(n.key));

    return Map.fromEntries([...output]);
  }

  @override
  List<Object?> get props => [text, groupIdsSelected];
}
