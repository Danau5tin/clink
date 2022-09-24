import 'package:clink_mobile_app/core/common/domain/entities/amount.dart';

class NetWorthEntry {
  final String id;
  final Amount assetsValue;
  final Amount liabilitiesValue;
  final DateTime dateTime;

  NetWorthEntry({
    required this.id,
    required this.assetsValue,
    required this.liabilitiesValue,
    required this.dateTime,
  });

  Amount get totalNWorth => Amount(
        currencyCode: assetsValue.currencyCode,
        value: assetsValue.value + liabilitiesValue.value,
      );
}
