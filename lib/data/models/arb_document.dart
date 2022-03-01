import 'dart:convert';

import 'package:equatable/equatable.dart';

class ArbDocument extends Equatable {
  final String projectName;
  final Map<String, ArbEntry> labels;
  final String mainLanguage;
  final Set<String> languages;
  final Map<String, String> groups;
  final String version;

  const ArbDocument({
    required this.projectName,
    this.labels = const {},
    required this.mainLanguage,
    required this.languages,
    this.groups = const {},
    this.version = '1.0.0',
  });

  ArbDocument copyWith({
    String? projectName,
    Map<String, ArbEntry>? labels,
    String? mainLanguage,
    Set<String>? languages,
    Map<String, String>? groups,
    String? version,
  }) {
    return ArbDocument(
      projectName: projectName ?? this.projectName,
      labels: labels ?? this.labels,
      mainLanguage: mainLanguage ?? this.mainLanguage,
      languages: languages ?? this.languages,
      groups: groups ?? this.groups,
      version: version ?? this.version,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'projectName': projectName,
      'labels': labels,
      'mainLanguage': mainLanguage,
      'languages': languages.toList(),
      'groups': groups,
      'version': version,
    };
  }

  factory ArbDocument.fromMap(Map<String, dynamic> map) {
    return ArbDocument(
      projectName: map['projectName'] ?? '',
      labels: Map<String, ArbEntry>.from(map['labels']),
      mainLanguage: map['mainLanguage'] ?? '',
      languages: Set<String>.from(map['languages']),
      groups: Map<String, String>.from(map['groups']),
      version: map['version'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ArbDocument.fromJson(String source) =>
      ArbDocument.fromMap(json.decode(source));

  @override
  List<Object?> get props => [
        projectName,
        labels,
        mainLanguage,
        languages,
        groups,
        version,
      ];
}

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
