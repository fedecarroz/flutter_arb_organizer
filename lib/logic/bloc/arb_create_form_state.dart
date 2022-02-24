part of 'arb_create_form_bloc.dart';

class ArbCreateFormState extends Equatable {
  final ArbCreateFormStatus status;
  final String name;
  final List<String> languages;
  final String mainLang;

  const ArbCreateFormState({
    this.status = ArbCreateFormStatus.initial,
    required this.name,
    required this.languages,
    required this.mainLang,
  });

  static ArbCreateFormState get empty => const ArbCreateFormState(
        name: '',
        languages: [],
        mainLang: '',
      );

  ArbCreateFormState copyWith({
    ArbCreateFormStatus? status,
    String? name,
    List<String>? languages,
    String? mainLang,
  }) {
    return ArbCreateFormState(
      name: name ?? this.name,
      languages: languages ?? this.languages,
      mainLang: mainLang ?? this.mainLang,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [status, name, languages, mainLang];
}

class ArbCreateFormSaveSuccess extends ArbCreateFormState {
  final ArbDocument arbDocument;

  const ArbCreateFormSaveSuccess({
    required this.arbDocument,
    required String name,
    required List<String> languages,
    required String mainLang,
  }) : super(
          name: name,
          languages: languages,
          mainLang: mainLang,
          status: ArbCreateFormStatus.saveSuccess,
        );

  @override
  List<Object?> get props => [status, name, languages, mainLang, arbDocument];
}

class ArbCreateFormSaveFailure extends ArbCreateFormState {
  final ArbCreateFormErrorType errorType;

  const ArbCreateFormSaveFailure({
    required this.errorType,
    required String name,
    required List<String> languages,
    required String mainLang,
  }) : super(
          name: name,
          languages: languages,
          mainLang: mainLang,
          status: ArbCreateFormStatus.saveFailure,
        );

  @override
  List<Object?> get props => [status, name, languages, mainLang, errorType];
}

enum ArbCreateFormStatus { initial, updateSuccess, saveSuccess, saveFailure }

enum ArbCreateFormErrorType { missingName, missingMainLang, lessThan2Langs }
