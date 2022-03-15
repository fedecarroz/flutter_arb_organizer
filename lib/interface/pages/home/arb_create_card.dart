part of 'home_page.dart';

class _ArbCreateCard extends StatelessWidget {
  const _ArbCreateCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ArbCreateFormBloc, ArbCreateFormState>(
      listener: (context, state) {
        if (state is ArbCreateFormSaveSuccess) {
          Navigator.pushNamed(
            context,
            projectEditorRoute,
            arguments: state.arbDocument,
          ).then((_) => resetHomeBlocs(context));
        }
      },
      child: MainCard(
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
                    onTap: () => context
                      ..read<HomeBloc>().add(HomeResetted())
                      ..read<ArbCreateFormBloc>().add(ArbCreateFormResetted()),
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
                    final newLanguages = await showLanguageSelectDialog(
                      context,
                      LanguagesSupported.values,
                      langsToRemove:
                          context.read<ArbCreateFormBloc>().state.languages,
                    );

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
                    children: <Widget>[
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
                  onPressed: () => _changeMainLang(context),
                  label: 'Cambia',
                ),
              ],
            ),
            const SizedBox(height: 20),
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
                    case ArbCreateFormErrorType.missingLangs:
                      message = 'Non è stata selezionata alcuna lingua';
                      break;
                  }

                  return Container(
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.only(bottom: 15),
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
      ),
    );
  }

  void _changeMainLang(BuildContext context) async {
    final languages = context.read<ArbCreateFormBloc>().state.languages;
    final newMainLang =
        await showSingleLanguageSelectDialog(context, languages);

    if (newMainLang != null) {
      context
          .read<ArbCreateFormBloc>()
          .add(ArbCreateFormMainLangUpdated(newMainLang));
    }
  }
}
