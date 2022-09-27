import 'package:clink_mobile_app/core/common/domain/entities/amount.dart';
import 'package:clink_mobile_app/core/common/presentation/utils/number_formatter.dart';
import 'package:clink_mobile_app/core/feature_registration/service_locator.dart';
import 'package:flutter/material.dart';

class DynamicAmountText extends StatelessWidget {
  final NumberFormatter numberFormatter = sl.get<NumberFormatter>();

  final Amount amount;
  final String? extraText;
  final TextStyle? textStyle;
  final Color? overrideColor;

  static Color? getColorFromComparison(double originalVal,double updatedVal) {
    if (originalVal == updatedVal) {
      return Colors.grey;
    }
    if (originalVal > updatedVal) {
      return Colors.red;
    }
    return Colors.green;
  }

  DynamicAmountText({
    required this.amount,
    this.extraText,
    this.textStyle,
    this.overrideColor,
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
        color: overrideColor ?? (amount.value >= 0 ? Colors.green : Colors.red),
      ),
    );
  }
}
