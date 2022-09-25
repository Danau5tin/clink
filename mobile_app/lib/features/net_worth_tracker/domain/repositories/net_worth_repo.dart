import 'package:clink_mobile_app/core/network/data_state/data_state.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/net_worth_data.dart';

abstract class NetWorthRepo {
  Future<DataState<NetWorthData, void>> fetchNWorthData();
}
