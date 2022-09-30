import 'package:clink_mobile_app/core/translations/translation_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GoBackButton extends StatelessWidget {
  const GoBackButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => Navigator.pop(context),
      icon: const Icon(CupertinoIcons.arrow_turn_up_left),
      label: Text('go_back'.tr),
    );
  }
}
