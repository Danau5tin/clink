import 'package:clink_mobile_app/core/crashlytics/crashlytics_reporter.dart';
import 'package:clink_mobile_app/core/feature_registration/service_locator.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/historical_net_worth.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/holdings.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/net_worth_data.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/net_worth_entry.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/repositories/net_worth_repo.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/presentation/state_management/n_worth_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final nWorthManagerProv = StateNotifierProvider<NWorthManager, NWorthState>(
  (ref) => sl.get<NWorthManager>(),
);

class NWorthManager extends StateNotifier<NWorthState> {
  final NetWorthRepo netWorthRepo;
  final CrashlyticsReporter crashlyticsReporter;

  NWorthManager({
    required this.netWorthRepo,
    required this.crashlyticsReporter,
  }) : super(const NWorthState.loading());

  Future<void> fetchNWData() async {
    final res = await netWorthRepo.fetchNWorthData();
    res.when(
      success: (d) => state = NWorthState.loaded(
        historicalNetWorthData: (d as NetWorthData).historicalNWorthData,
        holdings: d.holdings,
      ),
      failure: (e, _) {
        state = const NWorthState.error();
        crashlyticsReporter.reportException(e);
      },
    );
  }

  void notifyNewUpdate(NetWorthEntry newEntry, Holdings updatedHoldings) {
    state.maybeWhen(
      loaded: (historicalNetWorthData, holdings) {
        final newNWorthData = HistoricalNWorthData(
          entries: [...historicalNetWorthData.entries, newEntry],
        );
        state = NWorthState.loaded(
          historicalNetWorthData: newNWorthData,
          holdings: updatedHoldings,
        );
      },
      orElse: () => crashlyticsReporter
          .reportMessage('Trying to update state when state is $state'),
    );
  }
}
