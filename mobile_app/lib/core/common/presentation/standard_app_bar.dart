import 'package:flutter/material.dart';

class StandardAppBar extends AppBar {
  StandardAppBar({
    super.key,
    required BuildContext context,
    String? title,
    List<Widget>? actions,
  }) : super(
          title: title == null ? null : Text(title),
          centerTitle: true,
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.close,
              color: Colors.black,
            ),
          ),
          actions: actions,
        );
}
