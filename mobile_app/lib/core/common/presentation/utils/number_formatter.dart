import 'package:clink_mobile_app/core/common/domain/entities/amount.dart';
import 'package:clink_mobile_app/core/common/domain/misc/user_info_manager.dart';
import 'package:easy_localization/easy_localization.dart';

abstract class NumberFormatter {
  String toSimpleCurrency(double val, {String? currencyCode});

  String toSimpleCurrencyWithAmount(Amount amount);
}

class NumberFormatterImpl implements NumberFormatter {
  final UserManager userManager;

  NumberFormatterImpl({
    required this.userManager,
  });

  @override
  String toSimpleCurrency(double val, {String? currencyCode}) =>
      NumberFormat.simpleCurrency(
        name: currencyCode ?? userManager.usersBaseCurrency,
      ).format(val);

  @override
  String toSimpleCurrencyWithAmount(Amount amount) {
    return NumberFormat.simpleCurrency(name: amount.currencyCode)
        .format(amount.value);
  }
}
