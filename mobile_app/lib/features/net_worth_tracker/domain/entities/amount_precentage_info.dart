import 'package:clink_mobile_app/core/common/domain/entities/amount.dart';

class AmountPercentageInfo {
  final Amount amount;
  final double percentageChange;

  AmountPercentageInfo({
    required this.amount,
    required this.percentageChange,
  });
}
