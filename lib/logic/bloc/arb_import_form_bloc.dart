import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_arb_organizer/data.dart';

part 'arb_import_form_event.dart';
part 'arb_import_form_state.dart';

class ArbImportFormBloc extends Bloc<ArbImportFormEvent, ArbImportFormState> {
  ArbImportFormBloc() : super(ArbImportFormState.empty) {
    on<ArbImportFormResetted>((_, emit) => emit(ArbImportFormState.empty));
    on<ArbImportFormFileAdded>(_manageLangDocAdd);
    on<ArbImportFormProjectNameUpdated>(_manageProjectNameUpdate);
    on<ArbImportFormLangUpdated>(_manageLangDocUpdate);
    on<ArbImportFormMainLangUpdated>(_manageMainLangUpdate);
    on<ArbImportFormSubmitted>(_manageLangSubmit);
    on<ArbImportFormFilePickerRequested>(_manageImportRequest);
  }

  void _manageImportRequest(
    ArbImportFormFilePickerRequested event,
    Emitter<ArbImportFormState> emit,
  ) async {
    final files = await IORepository().readFiles(
      extensionsAllowed: [FilesSupported.arb],
    );
    final langs = _rebuildLanguages(files.whereType<ArbLanguage>().toList());
    emit(state.copyWith(languages: [...langs]));
  }

  List<ArbLanguage> _rebuildLanguages(List<ArbLanguage> newLangs) {
    final langDocsToAdd = newLangs;
    final currentLangs = List<ArbLanguage>.from(state.languages).map((langDoc) {
      final langDocToImportIndex =
          langDocsToAdd.indexWhere((_l) => _l.lang == langDoc.lang);

      if (langDocToImportIndex != -1) {
        final langRemovedFromNew = langDocsToAdd.removeAt(langDocToImportIndex);
        langDoc.entries.addAll(langRemovedFromNew.entries);
      }

      return langDoc;
    });

    return [...currentLangs, ...langDocsToAdd];
  }

  void _manageLangDocAdd(
    ArbImportFormFileAdded event,
    Emitter<ArbImportFormState> emit,
  ) {
    final langs = _rebuildLanguages(event.languages);
    emit(state.copyWith(languages: langs));
  }

  void _manageProjectNameUpdate(
    ArbImportFormProjectNameUpdated event,
    Emitter<ArbImportFormState> emit,
  ) {
    emit(state.copyWith(projectName: event.projectName));
  }

  void _manageLangDocUpdate(
    ArbImportFormLangUpdated event,
    Emitter<ArbImportFormState> emit,
  ) {
    final languages = List<ArbLanguage>.of(state.languages);
    final langIndexToChange = languages.indexWhere(
      (l) => l.lang == event.langToChange,
    );

    if (langIndexToChange != -1) {
      languages[langIndexToChange] = languages[langIndexToChange].copyWith(
        lang: event.langNewValue,
      );
    }

    emit(
      state.copyWith(
        languages: [...languages],
        mainLang:
            state.mainLang == event.langToChange ? event.langNewValue : null,
      ),
    );
  }

  void _manageMainLangUpdate(
    ArbImportFormMainLangUpdated event,
    Emitter<ArbImportFormState> emit,
  ) {
    emit(state.copyWith(mainLang: event.mainLang));
  }

  void _manageLangSubmit(
    ArbImportFormSubmitted event,
    Emitter<ArbImportFormState> emit,
  ) {
    ArbImportFormErrorType? errorType;

    if (state.projectName.isEmpty) {
      errorType = ArbImportFormErrorType.missingName;
    } else if (state.languages.isEmpty) {
      errorType = ArbImportFormErrorType.missingLangs;
    } else if (state.mainLang.isEmpty) {
      errorType = ArbImportFormErrorType.missingMainLang;
    }

    if (errorType != null) {
      return emit(
        ArbImportFormSaveFailure(
          errorType: errorType,
          projectName: state.projectName,
          languages: state.languages,
          mainLang: state.mainLang,
        ),
      );
    }

    final arbDocument = ArbDocument(
      projectName: state.projectName,
      mainLanguage: state.mainLang,
      languages: state.languages,
    );

    emit(
      ArbImportFormSaveSuccess(
        document: arbDocument,
        projectName: state.projectName,
        languages: state.languages,
        mainLang: state.mainLang,
      ),
    );
  }
}
