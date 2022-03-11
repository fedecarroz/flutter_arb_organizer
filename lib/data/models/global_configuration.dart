class GlobalConfiguration {
  static GlobalConfiguration? _istance;

  final String? arbDocumentPath;

  GlobalConfiguration._({this.arbDocumentPath});

  factory GlobalConfiguration() {
    return _istance ??= GlobalConfiguration._();
  }

  GlobalConfiguration copyWith({
    String? arbDocumentPath,
  }) {
    return _istance = GlobalConfiguration._(
      arbDocumentPath: arbDocumentPath ?? this.arbDocumentPath,
    );
  }
}
