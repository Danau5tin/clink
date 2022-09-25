import 'package:clink_mobile_app/core/common/domain/entities/amount.dart';
import 'package:easy_localization/easy_localization.dart';

abstract class NumberFormatter {
  String toSimpleCurrency(double val, {String? currencyCode});

  String toSimpleCurrencyWithAmount(Amount amount);
}

class NumberFormatterImpl implements NumberFormatter {
  // TODO: Remove hardcoded currency
  @override
  String toSimpleCurrency(double val, {String? currencyCode = 'GBP'}) =>
      NumberFormat.simpleCurrency(name: currencyCode).format(val);

  @override
  String toSimpleCurrencyWithAmount(Amount amount) {
    return NumberFormat.simpleCurrency(name: amount.currencyCode)
        .format(amount.value);
  }
}