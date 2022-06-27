import 'package:flutter/material.dart';

class MainCard extends StatelessWidget {
  final Widget child;
  final double width;

  const MainCard({
    Key? key,
    required this.child,
    this.width = 400,
  }) : super(key: key);

  const MainCard.dialog({Key? key, required Widget child})
      : this(
          key: key,
          child: child,
          width: 360,
        );

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
      width: width,
      padding: const EdgeInsets.all(30),
      child: child,
    );
  }
}

class CardHeader extends StatelessWidget {
  final String title;
  final void Function()? onBack;

  const CardHeader({Key? key, this.title = '', this.onBack}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        if (onBack != null) ...[
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: onBack?.call,
              child: const Icon(Icons.arrow_back_rounded),
            ),
          ),
          const SizedBox(width: 10),
        ],
        Text(
          title,
          style: TextStyle(
            color: Colors.blue[800],
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}
