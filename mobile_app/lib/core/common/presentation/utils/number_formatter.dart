import 'package:easy_localization/easy_localization.dart';

abstract class NumberFormatter {
  String toSimpleCurrency(double val, {String? currencyCode});
}

class NumberFormatterImpl implements NumberFormatter {
  // TODO: Remove hardcoded currency
  @override
  String toSimpleCurrency(double val, {String? currencyCode = 'GBP'}) =>
      NumberFormat.simpleCurrency(name: currencyCode).format(val);
}
