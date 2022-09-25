import 'package:clink_mobile_app/core/common/domain/entities/amount.dart';

class LossGainInfo {
  final Amount amount;
  final double percentageChange;

  LossGainInfo({
    required this.amount,
    required this.percentageChange,
  });
}
