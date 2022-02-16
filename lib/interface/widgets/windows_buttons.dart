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

class WindowTextButton extends WindowButton {
  WindowTextButton({
    Key? key,
    required String text,
    WindowButtonColors? colors,
    VoidCallback? onPressed,
    bool? animate,
  }) : super(
          key: key,
          colors: colors ??
              WindowButtonColors(
                normal: Colors.blue,
                mouseOver: Colors.blue[700],
                mouseDown: Colors.blue[800],
                iconNormal: Colors.white,
                iconMouseDown: Colors.white,
                iconMouseOver: Colors.white,
              ),
          animate: animate ?? false,
          iconBuilder: (buttonContext) => const SizedBox(),
          builder: (buttonContext, child) => Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          onPressed: onPressed ?? () {},
        );
}
