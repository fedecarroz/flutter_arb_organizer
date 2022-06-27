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
    on<ArbImportFormLangRemoved>(_manageLangRemove);
  }

  void _manageImportRequest(
    ArbImportFormFilePickerRequested event,
    Emitter<ArbImportFormState> emit,
  ) async {
    emit(
      state.copyWith(
        status: ArbImportFormStatus.updateProgress,
      ),
    );

    final files = await IORepository().readFiles(
      extensionsAllowed: [FilesSupported.arb],
    );

    final langs = _rebuildLanguages(files.whereType<ArbFile>().toList());

    emit(
      state.copyWith(
        languages: langs,
        status: ArbImportFormStatus.updateSuccess,
      ),
    );
  }

  List<ArbFile> _rebuildLanguages(List<ArbFile> newLangs) {
    final langDocsToAdd = List.of(newLangs);

    final currentLangs = state.languages.map((langDoc) {
      final langDocToImportIndex =
          langDocsToAdd.indexWhere((l) => l.lang == langDoc.lang);

      if (langDocToImportIndex != -1) {
        final langRemovedFromNew = langDocsToAdd.removeAt(langDocToImportIndex);
        langDoc.entries.addAll(langRemovedFromNew.entries);
      }

      return langDoc;
    }).toList();

    return [...currentLangs, ...langDocsToAdd];
  }

  void _manageLangDocAdd(
    ArbImportFormFileAdded event,
    Emitter<ArbImportFormState> emit,
  ) {
    emit(
      state.copyWith(
        status: ArbImportFormStatus.updateProgress,
      ),
    );

    final langs = _rebuildLanguages(event.languages);

    emit(
      state.copyWith(
        languages: langs,
        status: ArbImportFormStatus.updateSuccess,
      ),
    );
  }

  void _manageProjectNameUpdate(
    ArbImportFormProjectNameUpdated event,
    Emitter<ArbImportFormState> emit,
  ) {
    emit(
      state.copyWith(
        projectName: event.projectName,
        status: ArbImportFormStatus.updateSuccess,
      ),
    );
  }

  void _manageLangDocUpdate(
    ArbImportFormLangUpdated event,
    Emitter<ArbImportFormState> emit,
  ) {
    final languages = List<ArbFile>.of(state.languages);
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
        status: ArbImportFormStatus.updateSuccess,
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
    emit(state.copyWith(
      mainLang: event.mainLang,
      status: ArbImportFormStatus.updateSuccess,
    ));
  }

  void _manageLangRemove(
    ArbImportFormLangRemoved event,
    Emitter<ArbImportFormState> emit,
  ) {
    emit(
      state.copyWith(
        status: ArbImportFormStatus.updateProgress,
      ),
    );

    final langs = List.of(state.languages)
      ..removeWhere((l) => l.lang == event.language);

    final mainLangIsRemoved = !langs.any((l) => l.lang == state.mainLang);

    emit(
      state.copyWith(
        mainLang: mainLangIsRemoved ? '' : null,
        languages: langs,
        status: ArbImportFormStatus.updateSuccess,
      ),
    );
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

    final langSet = state.languages.map((l) => l.lang).toSet();
    var labels = <String, ArbEntry>{};

    for (var arbFile in state.languages) {
      arbFile.entries.forEach((key, value) {
        if (labels.containsKey(key)) {
          labels[key]!.localizedValues[arbFile.lang] = value;
        } else {
          final localizedValues = {arbFile.lang: value};
          final langsWithoutValue = {...langSet}..remove(arbFile.lang);

          for (final lang in langsWithoutValue) {
            localizedValues[lang] = '';
          }

          labels[key] = ArbEntry(
            key: key,
            localizedValues: localizedValues,
            groupId: '',
          );
        }
      });
    }

    final arbDocument = ArbDocument(
      projectName: state.projectName,
      mainLanguage: state.mainLang,
      languages: state.languages.map((l) => l.lang).toSet(),
      labels: labels,
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
