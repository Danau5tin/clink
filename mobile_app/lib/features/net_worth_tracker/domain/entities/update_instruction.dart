import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/fi_type.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/financial_item.dart';

class UpdateInstruction {
  final String financialItemId;
  final FiType fIType;
  final double valueChange;

  UpdateInstruction({
    required this.financialItemId,
    required this.fIType,
    required this.valueChange,
  });

  factory UpdateInstruction.fromFinancialItem(
    FinancialItem financialItem,
    double value,
  ) {
    return UpdateInstruction(
      financialItemId: financialItem.id,
      fIType: financialItem.type,
      valueChange: value,
    );
  }
}
