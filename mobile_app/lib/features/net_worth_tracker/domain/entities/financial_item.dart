import 'package:clink_mobile_app/core/common/domain/entities/amount.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/fi_type.dart';

class FinancialItem {
  final String id;
  final String name;
  final FiType type;
  final Amount currentValue;

  FinancialItem({
    required this.id,
    required this.name,
    required this.type,
    required this.currentValue,
  });

  FinancialItem copyWith({
    String? name,
    Amount? currentValue,
  }) {
    return FinancialItem(
      id: id,
      name: name ?? this.name,
      type: type,
      currentValue: currentValue ?? this.currentValue,
    );
  }
}
