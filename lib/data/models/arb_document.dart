import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_arb_organizer/data/models.dart';

const currentVersion = '1.0.0';

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
    this.version = currentVersion,
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
      projectName: map['projectName'] ?? 'new_project',
      labels: Map<String, ArbEntry>.from(map['labels']),
      mainLanguage: map['mainLanguage'] ?? 'it_IT',
      languages: Set<String>.from(map['languages']),
      groups: Map<String, String>.from(map['groups']),
      version: map['version'] ?? currentVersion,
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
