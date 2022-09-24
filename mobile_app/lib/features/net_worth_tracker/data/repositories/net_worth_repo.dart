import 'package:clink_mobile_app/core/network/data_state/data_state.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/assets_liabilites_holdings.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/historical_net_worth.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/net_worth_data.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/repositories/net_worth_repo.dart';

class NetWorthRepoLocalDb implements NetWorthRepo {
  @override
  Future<DataState<NetWorthData, void>> fetchNWorthData() async {
    try {
      final hDataFut = _fetchHistoricalNWData();
      final aLDataFut = _fetchAssetsLiabilties();
      return DataState.success(
        NetWorthData(
          historicalNWorthData: await hDataFut,
          assetsLiabilitiesHoldings: await aLDataFut,
        ),
      );
    } on Exception catch (e) {
      return DataState.failure(exception: e);
    }
  }

  Future<HistoricalNWorthData> _fetchHistoricalNWData() async {
    // TODO:
  }

  Future<AssetsLiabilitiesHoldings> _fetchAssetsLiabilties() async {
    // TODO:
  }
}
