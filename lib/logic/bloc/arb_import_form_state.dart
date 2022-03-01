part of 'arb_import_form_bloc.dart';

class ArbImportFormState extends Equatable {
  final ArbImportFormStatus status;
  final String mainLang;
  final List<ArbLanguage> languages;
  final String projectName;

  const ArbImportFormState({
    required this.status,
    required this.mainLang,
    required this.languages,
    required this.projectName,
  });

  static ArbImportFormState get empty => const ArbImportFormState(
        mainLang: '',
        languages: [],
        status: ArbImportFormStatus.initial,
        projectName: '',
      );

  ArbImportFormState copyWith({
    String? mainLang,
    ArbImportFormStatus? status,
    List<ArbLanguage>? languages,
    String? projectName,
  }) {
    return ArbImportFormState(
      mainLang: mainLang ?? this.mainLang,
      languages: languages ?? this.languages,
      status: status ?? this.status,
      projectName: projectName ?? this.projectName,
    );
  }

  @override
  List<Object?> get props => [status, mainLang, languages, projectName];
}

class ArbImportFormSaveSuccess extends ArbImportFormState {
  final ArbDocument document;

  const ArbImportFormSaveSuccess({
    required this.document,
    required String mainLang,
    required List<ArbLanguage> languages,
    required String projectName,
  }) : super(
          status: ArbImportFormStatus.saveSuccess,
          mainLang: mainLang,
          projectName: projectName,
          languages: languages,
        );

  @override
  List<Object?> get props => [
        document,
        status,
        mainLang,
        languages,
        projectName,
      ];
}

class ArbImportFormSaveFailure extends ArbImportFormState {
  final ArbImportFormErrorType errorType;

  const ArbImportFormSaveFailure({
    required this.errorType,
    required String mainLang,
    required List<ArbLanguage> languages,
    required String projectName,
  }) : super(
          status: ArbImportFormStatus.saveFailure,
          mainLang: mainLang,
          projectName: projectName,
          languages: languages,
        );

  @override
  List<Object?> get props => [
        errorType,
        status,
        mainLang,
        languages,
        projectName,
      ];
}

enum ArbImportFormStatus {
  initial,
  updateProgress,
  updateSuccess,
  saveSuccess,
  saveFailure,
}

enum ArbImportFormErrorType { missingName, missingMainLang, missingLangs }
