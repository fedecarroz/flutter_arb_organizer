part of 'home_page.dart';

class _ArbImportCard extends StatelessWidget {
  const _ArbImportCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ArbImportFormBloc, ArbImportFormState>(
      listener: (context, state) {
        if (state is ArbImportFormSaveSuccess) {
          Navigator.pushNamed(
            context,
            projectEditorRoute,
            arguments: state.document,
          ).then((_) => resetHomeBlocs(context));
        }
      },
      child: MainCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            CardHeader(
              title: 'Importa file Arb',
              onBack: () => context
                ..read<HomeBloc>().add(HomeResetted())
                ..read<ArbImportFormBloc>().add(ArbImportFormResetted()),
            ),
            const SizedBox(height: 20),
            TextFormField(
              // initialValue: state.name,
              decoration: const InputDecoration(
                hintText: 'Nome del progetto',
              ),
              onChanged: (name) => context
                  .read<ArbImportFormBloc>()
                  .add(ArbImportFormProjectNameUpdated(name)),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Expanded(
                  child: Text(
                    'Arb importati',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                SecondaryButton(
                  onPressed: () => context
                      .read<ArbImportFormBloc>()
                      .add(ArbImportFormFilePickerRequested()),
                  label: '+',
                  fontSize: 22,
                ),
              ],
            ),
            const SizedBox(height: 20),
            BlocBuilder<ArbImportFormBloc, ArbImportFormState>(
              builder: (context, state) {
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black26,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  width: double.maxFinite,
                  height: 200,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: ListView.builder(
                    physics: const ClampingScrollPhysics(),
                    itemCount: state.languages.length,
                    itemBuilder: (context, index) {
                      final langDoc = state.languages[index];
                      return ListTile(
                        minVerticalPadding: 0,
                        contentPadding: const EdgeInsets.all(0),
                        title: Text('ARB ${langDoc.lang}'),
                        subtitle: Text(
                          'Voci trovate: ${langDoc.entries.keys.length}',
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () => _changeSingleLang(
                                context,
                                langDoc.lang,
                              ),
                              icon: const Icon(Icons.edit),
                            ),
                            IconButton(
                              onPressed: () => context
                                  .read<ArbImportFormBloc>()
                                  .add(ArbImportFormLangRemoved(langDoc.lang)),
                              icon: const Icon(Icons.delete_outline),
                              padding: const EdgeInsets.only(left: 0),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: BlocBuilder<ArbImportFormBloc, ArbImportFormState>(
                    builder: (context, state) {
                      return Text(
                        'Lingua principale: ${state.mainLang}',
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
            BlocBuilder<ArbImportFormBloc, ArbImportFormState>(
              builder: (context, state) {
                if (state is ArbImportFormSaveFailure) {
                  String message = '';
                  switch (state.errorType) {
                    case ArbImportFormErrorType.missingName:
                      message = 'Nome mancante';
                      break;
                    case ArbImportFormErrorType.missingMainLang:
                      message =
                          'Non è stata selezionata alcuna lingua principale';
                      break;
                    case ArbImportFormErrorType.missingLangs:
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
                    margin: const EdgeInsets.symmetric(vertical: 20),
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
                  return const SizedBox(height: 20);
                }
              },
            ),
            Center(
              child: PrimaryButton(
                onPressed: () => context.read<ArbImportFormBloc>().add(
                      ArbImportFormSubmitted(),
                    ),
                label: 'Avanti',
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _changeMainLang(BuildContext context) async {
    final importFormBloc = context.read<ArbImportFormBloc>();
    final arbLangs = importFormBloc.state.languages;
    final languages = arbLangs.map((l) => l.lang).toList();

    final newMainLang =
        await showSingleLanguageSelectDialog(context, languages);

    if (newMainLang != null) {
      importFormBloc.add(ArbImportFormMainLangUpdated(newMainLang));
    }
  }

  void _changeSingleLang(BuildContext context, String currentLang) async {
    final importFormBloc = context.read<ArbImportFormBloc>();
    final arbLangs = importFormBloc.state.languages;
    final languages = arbLangs.map((l) => l.lang).toList();

    final langsAvailable = LanguagesSupported.values
        .where((lang) => !languages.contains(lang))
        .toList();

    final newLang = await showSingleLanguageSelectDialog(
      context,
      langsAvailable,
      dialogTitle: 'Aggiorna la lingua',
    );

    if (newLang != null) {
      importFormBloc.add(ArbImportFormLangUpdated(currentLang, newLang));
    }
  }
}
