import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';

class ProjectEditorPage extends StatelessWidget {
  const ProjectEditorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Flex(
        direction: Axis.horizontal,
        children: const <Widget>[
          Flexible(
            flex: 1,
            child: _LeftSide(),
          ),
          Flexible(
            flex: 3,
            child: _RightSide(),
          ),
        ],
      ),
    );
  }
}

class _LeftSide extends StatelessWidget {
  const _LeftSide({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[700],
      width: double.maxFinite,
      padding: EdgeInsets.only(
        top: appWindow.titleBarHeight + 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              'Nome del progetto'.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
              ),
            ),
          ),
          const SizedBox(height: 20),
          ...List.generate(
            3,
            (index) => _LeftButton(
              isSelected: index == 0 ? true : false,
              label: 'Gruppo ${index + 1}',
            ),
          ),
          const Expanded(child: SizedBox()),
          const _LeftButton(
            isSelected: false,
            label: '+',
            centerText: true,
          ),
        ],
      ),
    );
  }
}

class _LeftButton extends StatelessWidget {
  final bool isSelected;
  final String label;
  final bool centerText;

  const _LeftButton({
    Key? key,
    required this.isSelected,
    required this.label,
    this.centerText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected ? Colors.blue[900] : Colors.blue[700],
      child: InkWell(
        onTap: () {},
        hoverColor: Colors.blue[300],
        child: Container(
          height: 80,
          width: double.maxFinite,
          padding: centerText
              ? const EdgeInsets.all(0)
              : const EdgeInsets.only(left: 10),
          child: Align(
            alignment: centerText ? Alignment.center : Alignment.centerLeft,
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _RightSide extends StatelessWidget {
  const _RightSide({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GridView.builder(
          physics: const ClampingScrollPhysics(),
          padding: EdgeInsets.symmetric(
            vertical: appWindow.titleBarHeight + 20,
            horizontal: 20,
          ),
          itemCount: 20,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 50,
            mainAxisExtent: 180,
            mainAxisSpacing: 10,
          ),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Entry ${index + 1}',
                      style: TextStyle(
                        color: Colors.blue[800],
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 70,
                          child: Text(
                            'it_IT:',
                            style: TextStyle(
                              color: Colors.blue[800],
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            decoration: const InputDecoration(
                              hintText: 'Inserire testo',
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 70,
                          child: Text(
                            'en_US:',
                            style: TextStyle(
                              color: Colors.blue[800],
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            decoration: const InputDecoration(
                              hintText: 'Inserire testo',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        Container(
          height: appWindow.titleBarHeight + 20,
          margin: const EdgeInsets.only(right: 10),
          color: Colors.blue,
          alignment: Alignment.topCenter,
        ),
      ],
    );
  }
}
