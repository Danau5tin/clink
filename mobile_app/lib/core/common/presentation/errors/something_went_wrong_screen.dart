import 'package:flutter/material.dart';

import 'something_went_wrong_column.dart';

class SomethingWentWrongScreen extends StatelessWidget {
  final String? _message;

  const SomethingWentWrongScreen({
    String? message,
    Key? key,
  })  : _message = message,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: SomethingWentWrongColumn(message: _message)),
    );
  }
}
