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

class EditorButton extends StatelessWidget {
  final MaterialColor baseColor;
  final bool centerText;
  final bool specialColor;
  //final String label;
  final Widget child;
  final void Function()? onTap;
  final Color textColor;

  EditorButton({
    Key? key,
    this.baseColor = Colors.blue,
    this.centerText = false,
    this.specialColor = false,
    String label = '',
    required this.onTap,
    this.textColor = Colors.white,
  })  : child = Text(
          label,
          style: TextStyle(
            color: textColor,
            fontSize: 18,
          ),
        ),
        super(key: key);

  const EditorButton.widget({
    Key? key,
    this.baseColor = Colors.blue,
    this.centerText = false,
    this.specialColor = false,
    required this.child,
    required this.onTap,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: specialColor ? baseColor[900] : baseColor[700],
      child: InkWell(
        highlightColor: baseColor[900],
        hoverColor: baseColor[400],
        splashColor: baseColor[600],
        onTap: onTap,
        child: Container(
          alignment: centerText ? Alignment.center : Alignment.centerLeft,
          height: 70,
          width: double.maxFinite,
          padding: centerText
              ? const EdgeInsets.all(0)
              : const EdgeInsets.only(left: 10),
          child: child,
        ),
      ),
    );
  }
}
