import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_arb_organizer/data.dart';
import 'package:flutter_arb_organizer/helper.dart';
import 'package:flutter_arb_organizer/interface.dart';
import 'package:flutter_arb_organizer/logic/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

part 'arb_create_card.dart';
part 'arb_import_card.dart';
part 'welcome_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool goAhead = false;

  @override
  Widget build(BuildContext context) {
    var appLocal = AppLocalizations.of(context)!;

    return MultiBlocListener(
      listeners: [
        BlocListener<FileIOBloc, FileIOState>(
          listenWhen: (p, n) =>
              context.read<HomeBloc>().state is! HomeImportDocument,
          listener: _listenFileImportChanges,
        ),
        BlocListener<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state is HomeImportDocument) {
              Navigator.pushNamed(
                context,
                projectEditorRoute,
                arguments: state.arbDocument,
              ).then((_) => resetHomeBlocs(context));
            }
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.blue,
        body: DropTarget(
          onDragDone: (details) {
            context.read<FileIOBloc>().add(FileIODropped(details.files));
          },
          child: Center(
            child: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state is HomeCreateFormInit) {
                  return const _ArbCreateCard();
                } else if (state is HomeLanguagesImport) {
                  return const _ArbImportCard();
                } else {
                  return const _WelcomeCard();
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  void _listenFileImportChanges(BuildContext context, FileIOState state) {
    final homeState = context.read<HomeBloc>().state;
    if (state is FileIOLoadComplete && homeState is HomeLanguagesImport) {
      context.read<ArbImportFormBloc>().add(
            ArbImportFormFileAdded(
              state.docs.whereType<ArbFile>().toList(),
            ),
          );
    } else if (state is FileIOLoadComplete) {
      final documentQueryResult = state.docs.whereType<ArbDocument>();
      final languagesQueryResult = state.docs.whereType<ArbFile>();

      if (documentQueryResult.isNotEmpty) {
        context
            .read<HomeBloc>()
            .add(HomeDocumentImported(documentQueryResult.first));
      } else if (languagesQueryResult.isNotEmpty) {
        context
            .read<ArbImportFormBloc>()
            .add(ArbImportFormFileAdded(languagesQueryResult.toList()));

        context.read<HomeBloc>().add(HomeLanguagesImported());
      }
    }
  }
}

void resetHomeBlocs(BuildContext context) {
  context.read<ArbImportFormBloc>().add(ArbImportFormResetted());
  context.read<ArbCreateFormBloc>().add(ArbCreateFormResetted());
  context.read<FileIOBloc>().add(FileIOResetted());
  context.read<HomeBloc>().add(HomeResetted());
}
