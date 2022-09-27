import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/fi_type.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/financial_item.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_update_item_instruction.freezed.dart';

@freezed
class AddUpdateItemInstruction with _$AddUpdateItemInstruction {
  const factory AddUpdateItemInstruction.add({
    required FinancialItem item,
  }) = Add;

  const factory AddUpdateItemInstruction.update({
    required String idOfItem,
    String? newName,
    double? newValue,
  }) = Update;
}