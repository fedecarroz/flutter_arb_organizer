import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_arb_organizer/data.dart';

part 'arb_editor_event.dart';
part 'arb_editor_state.dart';

class ArbEditorBloc extends Bloc<ArbEditorEvent, ArbEditorState> {
  ArbEditorBloc(ArbDocument document) : super(ArbEditorInitial(document)) {
    on<ArbEditorEntryAdded>(_manageEntryAdded);
    on<ArbEditorEntryUpdated>(_manageEntryUpdated);
    on<ArbEditorEntryRemoved>(_manageEntryRemoved);
    on<ArbEditorGroupCreated>(_manageGroupCreated);
    on<ArbEditorGroupNameUpdated>(_manageGroupNameUpdated);
    on<ArbEditorGroupEntryAdded>(_manageGroupEntryAdded);
    on<ArbEditorGroupRemoved>(_manageGroupRemoved);
    on<ArbEditorLanguageAdded>(_manageLanguageAdded);
    on<ArbEditorLanguageUpdated>(_manageLanguageUpdated);
    on<ArbEditorLanguageRemoved>(_manageLanguageRemoved);
  }

  void _manageEntryAdded(
    ArbEditorEntryAdded event,
    Emitter<ArbEditorState> emit,
  ) {
    emit(ArbEditorDocumentUpdateInProgress(state.document));

    final labels = state.document.labels;

    if (labels.containsKey(event.arbEntry.key)) {
      emit(ArbEditorDocumentUpdateFailure(state.document));
    } else {
      labels[event.arbEntry.key] = event.arbEntry;
      emit(
        ArbEditorDocumentUpdateSuccess(
          state.document.copyWith(
            labels: labels,
          ),
        ),
      );
    }
  }

  void _manageEntryUpdated(
    ArbEditorEntryUpdated event,
    Emitter<ArbEditorState> emit,
  ) {
    emit(ArbEditorDocumentUpdateInProgress(state.document));

    final labels = state.document.labels;

    if (labels.containsKey(event.arbEntry.key)) {
      labels[event.arbEntry.key] = event.arbEntry;
      emit(
        ArbEditorDocumentUpdateSuccess(
          state.document.copyWith(
            labels: labels,
          ),
        ),
      );
    } else {
      emit(ArbEditorDocumentUpdateFailure(state.document));
    }
  }

  void _manageEntryRemoved(
    ArbEditorEntryRemoved event,
    Emitter<ArbEditorState> emit,
  ) {
    emit(ArbEditorDocumentUpdateInProgress(state.document));

    final labels = state.document.labels;

    final test = labels.remove(event.arbEntry.key);

    if (test != null) {
      emit(
        ArbEditorDocumentUpdateSuccess(
          state.document.copyWith(
            labels: labels,
          ),
        ),
      );
    } else {
      emit(ArbEditorDocumentUpdateFailure(state.document));
    }
  }

  void _manageGroupCreated(
    ArbEditorGroupCreated event,
    Emitter<ArbEditorState> emit,
  ) {
    emit(ArbEditorDocumentUpdateInProgress(state.document));

    final _keys = state.document.groups.keys.toSet();
    final _values = state.document.groups.values.toList();

    String groupId;
    do {
      groupId = UniqueKey().toString();
    } while (_keys.contains(groupId));

    _keys.add(groupId);
    _values.add(event.groupName);

    final groups = Map.fromIterables(_keys, _values);

    emit(
      ArbEditorDocumentUpdateSuccess(
        state.document.copyWith(
          groups: groups,
        ),
      ),
    );
  }

  void _manageGroupNameUpdated(
    ArbEditorGroupNameUpdated event,
    Emitter<ArbEditorState> emit,
  ) {
    emit(ArbEditorDocumentUpdateInProgress(state.document));

    var groups = state.document.groups;

    groups[event.groupId] = event.groupName;

    emit(
      ArbEditorDocumentUpdateSuccess(
        state.document.copyWith(
          groups: groups,
        ),
      ),
    );
  }

  void _manageGroupEntryAdded(
    ArbEditorGroupEntryAdded event,
    Emitter<ArbEditorState> emit,
  ) {
    emit(ArbEditorDocumentUpdateInProgress(state.document));

    var arbEntry = event.arbEntry.copyWith(
      groupId: event.groupId,
    );

    var labels = state.document.labels;

    labels[arbEntry.key] = arbEntry;

    emit(
      ArbEditorDocumentUpdateSuccess(
        state.document.copyWith(
          labels: labels,
        ),
      ),
    );
  }

  void _manageGroupRemoved(
    ArbEditorGroupRemoved event,
    Emitter<ArbEditorState> emit,
  ) {
    emit(ArbEditorDocumentUpdateInProgress(state.document));

    var groups = state.document.groups;
    var labels = state.document.labels;

    groups.remove(event.groupId);

    if (event.removeEntries) {
      labels.removeWhere(
        (key, value) => value.groupId == event.groupId,
      );
    }

    emit(
      ArbEditorDocumentUpdateSuccess(
        state.document.copyWith(
          groups: groups,
          labels: labels,
        ),
      ),
    );
  }

  void _manageLanguageAdded(
    ArbEditorLanguageAdded event,
    Emitter<ArbEditorState> emit,
  ) {
    emit(ArbEditorDocumentUpdateInProgress(state.document));

    var languages = state.document.languages;
    if (languages.add(event.lang)) {
      emit(
        ArbEditorDocumentUpdateSuccess(
          state.document.copyWith(languages: languages),
        ),
      );
    } else {
      emit(ArbEditorDocumentUpdateFailure(state.document));
    }
  }

  void _manageLanguageUpdated(
    ArbEditorLanguageUpdated event,
    Emitter<ArbEditorState> emit,
  ) {
    emit(ArbEditorDocumentUpdateInProgress(state.document));

    var languages = state.document.languages;
    if (languages.contains(event.oldLang)) {
      var langMap = languages.map(
        (value) => value == event.oldLang ? event.newLang : value,
      );

      emit(
        ArbEditorDocumentUpdateSuccess(
          state.document.copyWith(
            languages: langMap.toSet(),
          ),
        ),
      );
    } else {
      emit(ArbEditorDocumentUpdateFailure(state.document));
    }
  }

  void _manageLanguageRemoved(
    ArbEditorLanguageRemoved event,
    Emitter<ArbEditorState> emit,
  ) {
    emit(ArbEditorDocumentUpdateInProgress(state.document));

    var languages = state.document.languages;
    if (languages.contains(event.lang)) {
      languages.remove(event.lang);
      emit(
        ArbEditorDocumentUpdateSuccess(
          state.document.copyWith(
            languages: languages,
          ),
        ),
      );
    } else {
      emit(ArbEditorDocumentUpdateFailure(state.document));
    }
  }
}
