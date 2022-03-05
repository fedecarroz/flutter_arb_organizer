import 'dart:convert';

import 'package:equatable/equatable.dart';

class ArbEntry extends Equatable {
  final String key;
  final Map<String, String> localizedValues;
  final String groupId;

  const ArbEntry({
    required this.key,
    required this.localizedValues,
    required this.groupId,
  });

  ArbEntry copyWith({
    String? key,
    Map<String, String>? localizedValues,
    String? groupId,
  }) {
    return ArbEntry(
      key: key ?? this.key,
      localizedValues: localizedValues ?? this.localizedValues,
      groupId: groupId ?? this.groupId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'key': key,
      'localizedValues': localizedValues,
      'groupId': groupId,
    };
  }

  factory ArbEntry.fromMap(Map<String, dynamic> map) {
    return ArbEntry(
      key: map['key'] ?? '',
      localizedValues: Map<String, String>.from(map['localizedValues']),
      groupId: map['groupId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ArbEntry.fromJson(String source) =>
      ArbEntry.fromMap(json.decode(source));

  @override
  List<Object?> get props => [key, localizedValues, groupId];
}
