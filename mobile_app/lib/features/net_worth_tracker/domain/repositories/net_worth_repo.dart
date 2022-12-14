import 'package:clink_mobile_app/core/network/data_state/data_state.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/add_update_item_instruction.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/net_worth_data.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/net_worth_entry.dart';

abstract class NetWorthRepo {
  Future<DataState<NetWorthData, void>> fetchNWorthData();

  Future<DataState<bool, void>> updateFinancials({
    required NetWorthEntry netWorthEntry,
    required List<AddUpdateItemInstruction> instructions,
  });
}
