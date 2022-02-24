part of 'arb_create_form_bloc.dart';

abstract class ArbCreateFormEvent extends Equatable {}

class ArbCreateFormResetted extends ArbCreateFormEvent {
  @override
  List<Object?> get props => [];
}

class ArbCreateFormNameUpdated extends ArbCreateFormEvent {
  final String name;

  ArbCreateFormNameUpdated(this.name);

  @override
  List<Object?> get props => [name];
}

class ArbCreateFormMainLangUpdated extends ArbCreateFormEvent {
  final String lang;

  ArbCreateFormMainLangUpdated(this.lang);

  @override
  List<Object?> get props => [lang];
}

class ArbCreateFormLanguagesAdded extends ArbCreateFormEvent {
  final List<String> langs;

  ArbCreateFormLanguagesAdded(this.langs);

  @override
  List<Object?> get props => [langs];
}

class ArbCreateFormLanguageRemoved extends ArbCreateFormEvent {
  final String lang;

  ArbCreateFormLanguageRemoved(this.lang);

  @override
  List<Object?> get props => [lang];
}

class ArbCreateFormSubmitted extends ArbCreateFormEvent {
  @override
  List<Object?> get props => [];
}
