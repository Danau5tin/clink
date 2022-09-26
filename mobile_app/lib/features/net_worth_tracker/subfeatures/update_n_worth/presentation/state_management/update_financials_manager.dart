import 'package:clink_mobile_app/core/common/domain/entities/amount.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/amount_precentage_info.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/fi_type.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/holdings.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/presentation/state_management/n_worth_manager.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/subfeatures/update_n_worth/presentation/state_management/update_financials_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final updateFinsManProv = StateNotifierProvider.autoDispose<
    UpdateFinancialsManager, UpdateFinancialsState>(
  (ref) => UpdateFinancialsManager(
    holdings: ref.read(nWorthManagerProv).maybeWhen(
          loaded: (historicalNetWorthData, holdings) => holdings,
          orElse: () => Holdings(financialItems: []),
        ),
  ),
);

class UpdateFinancialsManager extends StateNotifier<UpdateFinancialsState> {
  UpdateFinancialsManager({required Holdings holdings})
      : super(
          UpdateFinancialsState.initial(
            originalHoldings:
                Holdings(financialItems: [...holdings.financialItems]),
            updatedHoldings:
                Holdings(financialItems: [...holdings.financialItems]),
          ),
        );

  AmountPercentageInfo getUpdatedValueFor(FiType fiType) {
    return state.maybeWhen(
      initial: (originalHoldings, updatedHoldings, saving) {
        final originalAmount = originalHoldings.valueOfItems(
          fiType.when(
            account: () => originalHoldings.getAllAccounts,
            physAsset: () => originalHoldings.getAllPhysAssets,
            liability: () => originalHoldings.getAllLiabilities,
          ),
        );
        final newAmount = updatedHoldings.valueOfItems(
          fiType.when(
            account: () => updatedHoldings.getAllAccounts,
            physAsset: () => updatedHoldings.getAllPhysAssets,
            liability: () => updatedHoldings.getAllLiabilities,
          ),
        );
        return AmountPercentageInfo( // TODO: Stop hardcoding currency
          amount: Amount(currencyCode: 'GBP', value: newAmount),
          percentageChange: _calculatePercChange(newAmount, originalAmount),
        );
      },
      orElse: () {
        throw Exception('Should not be able to access in state $state');
      },
    );
  }

  double _calculatePercChange(double newAmount, double originalAmount) =>
      ((newAmount - originalAmount) / originalAmount) * 100;
}
