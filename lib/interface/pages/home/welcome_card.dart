part of 'home_page.dart';

class _WelcomeCard extends StatelessWidget {
  const _WelcomeCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainCard(
      child: Column(
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
      ),
    );
  }
}
