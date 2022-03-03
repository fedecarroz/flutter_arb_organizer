import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_arb_organizer/data.dart';

part 'arb_create_form_event.dart';
part 'arb_create_form_state.dart';

class ArbCreateFormBloc extends Bloc<ArbCreateFormEvent, ArbCreateFormState> {
  ArbCreateFormBloc() : super(ArbCreateFormState.empty) {
    on<ArbCreateFormResetted>((_, emit) => emit(ArbCreateFormState.empty));

    on<ArbCreateFormNameUpdated>(
      (event, emit) => emit(
        state.copyWith(
          status: ArbCreateFormStatus.updateSuccess,
          name: event.name,
        ),
      ),
    );

    on<ArbCreateFormMainLangUpdated>(
      (event, emit) => emit(
        state.copyWith(
          status: ArbCreateFormStatus.updateSuccess,
          mainLang: event.lang,
        ),
      ),
    );

    on<ArbCreateFormLanguagesAdded>(
      (event, emit) {
        final langs = List<String>.from(state.languages);

        emit(
          state.copyWith(
            status: ArbCreateFormStatus.updateSuccess,
            languages: [...langs, ...event.langs],
          ),
        );
      },
    );

    on<ArbCreateFormLanguageRemoved>(
      (event, emit) {
        final langs = List<String>.from(state.languages)..remove(event.lang);

        emit(
          state.copyWith(
            status: ArbCreateFormStatus.updateSuccess,
            languages: [...langs],
          ),
        );
      },
    );

    on<ArbCreateFormSubmitted>(
      (event, emit) {
        ArbCreateFormErrorType? errorType;

        if (state.name.isEmpty) {
          errorType = ArbCreateFormErrorType.missingName;
        } else if (state.languages.isEmpty) {
          errorType = ArbCreateFormErrorType.missingLangs;
        } else if (state.mainLang.isEmpty) {
          errorType = ArbCreateFormErrorType.missingMainLang;
        }

        if (errorType != null) {
          return emit(
            ArbCreateFormSaveFailure(
              errorType: errorType,
              name: state.name,
              languages: state.languages,
              mainLang: state.mainLang,
            ),
          );
        }

        final arbDocument = ArbDocument(
          projectName: state.name,
          mainLanguage: state.mainLang,
          languages: state.languages.toSet(),
        );

        emit(
          ArbCreateFormSaveSuccess(
              arbDocument: arbDocument,
              name: state.name,
              languages: state.languages,
              mainLang: state.mainLang),
        );
      },
    );
  }
}
