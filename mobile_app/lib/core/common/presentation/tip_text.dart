import 'package:flutter/material.dart';

class TipText extends StatelessWidget {
  final String text;

  const TipText({
    required this.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.caption,
      textAlign: TextAlign.center,
    );
  }
}
