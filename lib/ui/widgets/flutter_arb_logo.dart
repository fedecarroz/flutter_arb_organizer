import 'package:flutter/material.dart';

class FlutterArbLogo extends StatelessWidget {
  const FlutterArbLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.text_fields,
          color: Colors.blue[100]!.withValues(alpha: 0.3),
          size: 250,
        ),
        const SizedBox(width: 30),
        Text(
          'Flutter ARB Organizer',
          style: TextStyle(
            color: Colors.blue[100]!.withValues(alpha: 0.3),
            fontSize: 50,
          ),
        ),
      ],
    );
  }
}
