import 'package:clink_mobile_app/core/common/domain/entities/amount.dart';
import 'package:clink_mobile_app/core/common/presentation/utils/number_formatter.dart';
import 'package:clink_mobile_app/core/feature_registration/service_locator.dart';
import 'package:flutter/material.dart';

class DynamicAmountText extends StatelessWidget {
  final NumberFormatter numberFormatter = sl.get<NumberFormatter>();

  final Amount amount;
  final String? extraText;
  final TextStyle? textStyle;
  final bool greyOut;

  DynamicAmountText({
    required this.amount,
    this.extraText,
    this.textStyle,
    this.greyOut = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      '${numberFormatter.toSimpleCurrency(
        amount.value,
        currencyCode: amount.currencyCode,
      )}${extraText == null ? '' : ' $extraText'}',
      style: (textStyle ?? Theme.of(context).textTheme.bodyText1!).copyWith(
        color: greyOut
            ? Colors.grey
            : amount.value >= 0
                ? Colors.green
                : Colors.red,
      ),
    );
  }
}
