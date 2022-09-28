import 'package:clink_mobile_app/core/common/presentation/light_rounded_container.dart';
import 'package:clink_mobile_app/core/common/presentation/theme/colors.dart';
import 'package:clink_mobile_app/core/common/presentation/utils/number_formatter.dart';
import 'package:clink_mobile_app/core/feature_registration/service_locator.dart';
import 'package:flutter/material.dart';

class BalanceEntryDisplay extends StatelessWidget {
  final NumberFormatter _numberFormatter = sl.get<NumberFormatter>();

  final String entry;
  final String title;
  final Color? entryColor;
  final String? prefix;

  BalanceEntryDisplay({
    required this.entry,
    required this.title,
    this.entryColor,
    this.prefix,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formattedEntry = _numberFormatter.toSimpleCurrency(
      double.parse(entry),
      currencyCode: '',
    );
    return Column(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
        ),
        Text(
          prefix == null ? formattedEntry : '$prefix$formattedEntry',
          maxLines: 2,
          overflow: TextOverflow.fade,
          style: Theme.of(context).textTheme.headline1!.copyWith(
                color: entryColor ?? Theme.of(context).primaryColor,
                fontSize: 70,
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
