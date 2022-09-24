import 'package:clink_mobile_app/core/translations/translation_provider.dart';
import 'package:clink_mobile_app/core/common/presentation/dynamic_sized_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SomethingWentWrongColumn extends StatelessWidget {
  final String? message;

  const SomethingWentWrongColumn({
    this.message,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            CupertinoIcons.exclamationmark_circle_fill,
            color: Colors.red,
            size: MediaQuery.of(context).size.height * 0.4,
          ),
          Center(
            child: Text(
              message ?? 'sorry_something_w_w'.tr,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          DynamicHSizedBox.xxl(),
          ElevatedButton.icon(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(CupertinoIcons.arrow_turn_up_left),
            label: Text('go_back'.tr),
          )
        ],
      ),
    );
  }
}
