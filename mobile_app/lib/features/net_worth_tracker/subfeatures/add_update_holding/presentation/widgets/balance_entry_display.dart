import 'package:clink_mobile_app/core/common/presentation/light_rounded_container.dart';
import 'package:clink_mobile_app/core/common/presentation/theme/colors.dart';
import 'package:clink_mobile_app/core/translations/translation_provider.dart';
import 'package:flutter/material.dart';

class BalanceEntryDisplay extends StatelessWidget {
  final String entry;
  final bool isUpdate;

  const BalanceEntryDisplay({
    required this.entry,
    required this.isUpdate,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          isUpdate ? 'current_balance'.tr : 'new_balance'.tr,
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
        ),
        Text(
          entry,
          maxLines: 2,
          overflow: TextOverflow.fade,
          style: Theme.of(context).textTheme.headline2!.copyWith(
                color: Theme.of(context).primaryColor,
              ),
        ),
        LightRoundedContainer(
          padding: const EdgeInsets.all(8),
          borderRadius: 16,
          child: Text(
            'GBP',
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: CColors.greyText, fontSize: 12),
          ),
        )
      ],
    );
  }
}