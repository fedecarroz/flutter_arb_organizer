import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';

final buttonColors = WindowButtonColors(
  mouseOver: Colors.blue[700],
  mouseDown: Colors.blue[800],
  iconNormal: Colors.white,
  iconMouseOver: Colors.white,
  iconMouseDown: Colors.white,
);

final closeButtonColors = WindowButtonColors(
  mouseOver: Colors.red,
  mouseDown: Colors.red,
  iconNormal: Colors.white,
  iconMouseOver: Colors.white,
);

class WindowButtons extends StatelessWidget {
  const WindowButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MinimizeWindowButton(colors: buttonColors),
        MaximizeWindowButton(colors: buttonColors),
        CloseWindowButton(colors: closeButtonColors),
      ],
    );
  }
}

class PrimaryButton extends StatelessWidget {
  final void Function()? onPressed;
  final String label;
  final double fontSize;

  const PrimaryButton({
    Key? key,
    required this.onPressed,
    required this.label,
    this.fontSize = 16,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Center(child: Text(label)),
      style: ElevatedButton.styleFrom(
        alignment: Alignment.center,
        elevation: 0,
        minimumSize: const Size(160, 40),
        primary: Colors.blue[800],
        textStyle: TextStyle(
          color: Colors.white,
          fontSize: fontSize,
        ),
      ),
    );
  }
}

class SecondaryButton extends StatelessWidget {
  final void Function()? onPressed;
  final String label;
  final double fontSize;

  const SecondaryButton({
    Key? key,
    required this.onPressed,
    required this.label,
    this.fontSize = 16,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      child: Center(child: Text(label)),
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(0, 40),
        primary: Colors.blue[800],
        textStyle: TextStyle(
          color: Colors.white,
          fontSize: fontSize,
        ),
      ),
    );
  }
}
