import 'package:flutter/material.dart';

class StandardAppBar extends AppBar {
  StandardAppBar({
    super.key,
    required BuildContext context,
    bool largeTitle = false,
    bool hideLeading = false,
    String? title,
    List<Widget>? actions,
  }) : super(
          title: title == null
              ? null
              : Text(
                  title,
                  style:
                      largeTitle ? Theme.of(context).textTheme.headline2 : null,
                ),
          centerTitle: true,
          leading: hideLeading
              ? const SizedBox()
              : GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.close,
                    color: Colors.black,
                  ),
                ),
          actions: actions,
        );
}
