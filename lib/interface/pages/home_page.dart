import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_arb_organizer/data.dart';
import 'package:flutter_arb_organizer/interface.dart';
import 'package:flutter_arb_organizer/logic/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
          listenWhen: (p, n) => context.read<HomeBloc>().state is HomeInitial,
          listener: (context, state) {
            if (state is FileIOLoadComplete) {
              final documentQueryResult = state.docs.whereType<ArbDocument>();
              final languagesQueryResult = state.docs.whereType<ArbLanguage>();

              if (documentQueryResult.isNotEmpty) {
                context
                    .read<HomeBloc>()
                    .add(HomeDocumentLaunched(documentQueryResult.first));
              } else if (languagesQueryResult.isNotEmpty) {}
            }
          },
        ),
        BlocListener<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state is HomeLaunchDocumentComplete) {
              Navigator.pushNamed(
                context,
                projectEditorRoute,
                arguments: state.arbDocument,
              );
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
                return _MainCard(
                  child: state is HomeCreateFormInitComplete
                      ? const _ProjectDetails()
                      : const _WelcomeSection(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _MainCard extends StatelessWidget {
  final Widget child;

  const _MainCard({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
          ),
        ],
      ),
      width: 400,
      padding: const EdgeInsets.all(30),
      child: child,
    );
  }
}

class _WelcomeSection extends StatelessWidget {
  const _WelcomeSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          'Flutter ARB Organizer',
          style: TextStyle(
            color: Colors.blue[800],
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            PrimaryButton(
              onPressed: () {
                context.read<HomeBloc>().add(HomeCreateInitialized());
              },
              label: 'Nuovo progetto',
            ),
            PrimaryButton(
              onPressed: () {
                context.read<FileIOBloc>().add(FileIOLoadStarted());
              },
              label: 'Importa file.arb',
            ),
          ],
        ),
      ],
    );
  }
}

class _ProjectDetails extends StatelessWidget {
  const _ProjectDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ArbCreateFormBloc, ArbCreateFormState>(
      listener: (context, state) {
        if (state is ArbCreateFormSaveSuccess) {
          Navigator.pushNamed(
            context,
            projectEditorRoute,
            arguments: state.arbDocument,
          );
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  child: const Icon(
                    Icons.arrow_back_rounded,
                  ),
                  onTap: () => context.read<HomeBloc>().add(HomeResetted()),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                'Dettagli progetto',
                style: TextStyle(
                  color: Colors.blue[800],
                  fontSize: 20,
                ),
              ),
            ],
          ),
          BlocBuilder<ArbCreateFormBloc, ArbCreateFormState>(
            builder: (context, state) {
              if (state is ArbCreateFormSaveFailure) {
                String message = '';
                switch (state.errorType) {
                  case ArbCreateFormErrorType.missingName:
                    message = 'Nome mancante';
                    break;
                  case ArbCreateFormErrorType.missingMainLang:
                    message =
                        'Non è stata selezionata alcuna lingua principale';
                    break;
                  case ArbCreateFormErrorType.lessThan2Langs:
                    message = 'Bisogna selezionare almeno 2 lingue supportate';
                    break;
                }

                return Container(
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding: const EdgeInsets.all(15),
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Errore',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        message,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return const SizedBox(height: 10);
              }
            },
          ),
          BlocBuilder<ArbCreateFormBloc, ArbCreateFormState>(
            builder: (context, state) {
              return TextFormField(
                initialValue: state.name,
                decoration: const InputDecoration(
                  hintText: 'Nome del progetto',
                ),
                onChanged: (name) => context
                    .read<ArbCreateFormBloc>()
                    .add(ArbCreateFormNameUpdated(name)),
              );
            },
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: BlocBuilder<ArbCreateFormBloc, ArbCreateFormState>(
                  builder: (context, state) {
                    final mainLang = state.mainLang.isNotEmpty
                        ? state.mainLang
                        : 'non inserita';

                    return Text(
                      'Lingua principale: $mainLang',
                      style: const TextStyle(fontSize: 16),
                    );
                  },
                ),
              ),
              SecondaryButton(
                onPressed: () => _showMainLanguageSelectDialog(context).then(
                  (mainLang) {
                    if (mainLang != null) {
                      context
                          .read<ArbCreateFormBloc>()
                          .add(ArbCreateFormMainLangUpdated(mainLang));
                    }
                  },
                ),
                label: 'Cambia',
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Expanded(
                child: Text(
                  'Lingue supportate:',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              SecondaryButton(
                onPressed: () async {
                  final newLanguages = await _showLanguageSelectDialog(context);

                  if (newLanguages != null) {
                    context
                        .read<ArbCreateFormBloc>()
                        .add(ArbCreateFormLanguagesAdded(newLanguages));
                  }
                },
                label: '+',
                fontSize: 22,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black26,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            width: double.maxFinite,
            padding: const EdgeInsets.all(15),
            child: BlocBuilder<ArbCreateFormBloc, ArbCreateFormState>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (state.languages.isEmpty)
                      const SizedBox(
                        height: 50,
                        child: Center(
                          child: Text('Nessuna lingua aggiunta'),
                        ),
                      ),
                    for (final lang in state.languages) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              lang,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () => context
                                  .read<ArbCreateFormBloc>()
                                  .add(ArbCreateFormLanguageRemoved(lang)),
                              child: const Icon(Icons.delete_outline),
                            ),
                          ),
                        ],
                      ),
                    ]
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: PrimaryButton(
              onPressed: () => context
                  .read<ArbCreateFormBloc>()
                  .add(ArbCreateFormSubmitted()),
              label: 'Avanti',
            ),
          ),
        ],
      ),
    );
  }

  Future<String?> _showMainLanguageSelectDialog(BuildContext context) async {
    final languages = context.read<ArbCreateFormBloc>().state.languages;
    return showDialog<String?>(
      context: context,
      builder: (context) {
        return Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                ),
              ],
            ),
            width: 400,
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        child: const Icon(Icons.arrow_back_rounded),
                        onTap: () => Navigator.pop(context),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Scegli la lingua principale',
                      style: TextStyle(
                        color: Colors.blue[800],
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                if (languages.isEmpty)
                  SizedBox(
                    height: 100,
                    child: Center(
                      child: Text(
                        'Nessuna lingua supportata presente',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ),
                  )
                else
                  const SizedBox(height: 15),
                for (final lang in languages) ...[
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => Navigator.pop(context, lang),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Text(
                          lang,
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ),
                    ),
                  ),
                ]
              ],
            ),
          ),
        );
      },
    );
  }

  Future<List<String>?> _showLanguageSelectDialog(BuildContext context) async {
    final languagesAlreadyAdded =
        context.read<ArbCreateFormBloc>().state.languages;

    final languages = LanguagesSupported.values
        .where((l) => !languagesAlreadyAdded.contains(l))
        .toList();

    final languagesSelected = <String>{};

    return showDialog<List<String>?>(
      context: context,
      builder: (context) {
        return Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                ),
              ],
            ),
            width: 400,
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        child: const Icon(Icons.arrow_back_rounded),
                        onTap: () => Navigator.pop(context),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Scegli le lingua supportate',
                      style: TextStyle(
                        color: Colors.blue[800],
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                if (languages.isEmpty)
                  SizedBox(
                    height: 100,
                    child: Center(
                      child: Text(
                        'Nessuna lingua presente',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ),
                  )
                else
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: StatefulBuilder(
                        builder: (context, StateSetter setState) {
                      return ConstrainedBox(
                        constraints: const BoxConstraints(maxHeight: 300),
                        child: ListView.builder(
                          physics: const ClampingScrollPhysics(),
                          itemCount: languages.length,
                          itemBuilder: (context, i) {
                            final lang = languages[i];

                            return Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    lang,
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                Material(
                                  child: Checkbox(
                                    value: languagesSelected.contains(lang),
                                    onChanged: (checked) => setState(() {
                                      if (checked == true) {
                                        languagesSelected.add(lang);
                                      } else {
                                        languagesSelected.remove(lang);
                                      }
                                    }),
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                      );
                    }),
                  ),
                if (languages.isNotEmpty)
                  Row(
                    children: [
                      Flexible(
                        child: PrimaryButton(
                          label: 'Salva',
                          onPressed: () => Navigator.pop(
                            context,
                            List.of(languagesSelected),
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Flexible(
                        child: SecondaryButton(
                          label: 'Chiudi',
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
