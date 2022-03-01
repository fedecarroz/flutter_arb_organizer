part of 'arb_import_form_bloc.dart';

abstract class ArbImportFormEvent extends Equatable {}

class ArbImportFormResetted extends ArbImportFormEvent {
  @override
  List<Object?> get props => [];
}

class ArbImportFormProjectNameUpdated extends ArbImportFormEvent {
  final String projectName;

  ArbImportFormProjectNameUpdated(this.projectName);

  @override
  List<Object?> get props => [projectName];
}

class ArbImportFormFilePickerRequested extends ArbImportFormEvent {
  @override
  List<Object?> get props => [];
}

class ArbImportFormFileAdded extends ArbImportFormEvent {
  final List<ArbLanguage> languages;

  ArbImportFormFileAdded(this.languages);

  @override
  List<Object?> get props => [languages];
}

class ArbImportFormLangRemoved extends ArbImportFormEvent {
  final String language;

  ArbImportFormLangRemoved(this.language);

  @override
  List<Object?> get props => [language];
}

class ArbImportFormLangUpdated extends ArbImportFormEvent {
  final String langToChange;
  final String langNewValue;

  ArbImportFormLangUpdated(this.langToChange, this.langNewValue);

  @override
  List<Object?> get props => [langNewValue, langToChange];
}

class ArbImportFormMainLangUpdated extends ArbImportFormEvent {
  final String mainLang;

  ArbImportFormMainLangUpdated(this.mainLang);
  @override
  List<Object?> get props => [mainLang];
}

class ArbImportFormSubmitted extends ArbImportFormEvent {
  @override
  List<Object?> get props => [];
}
