import 'package:clink_mobile_app/core/common/domain/entities/amount.dart';
import 'package:clink_mobile_app/core/common/domain/misc/uuid_gen.dart';
import 'package:clink_mobile_app/core/feature_registration/service_locator.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/add_update_item_instruction.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/amount_precentage_info.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/fi_type.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/financial_item.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/holdings.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/net_worth_entry.dart';
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
  final UUIDGen uuidGen = sl.get<UUIDGen>();

  UpdateFinancialsManager({
    required Holdings holdings,
  }) : super(
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
        return AmountPercentageInfo(
          // TODO: Stop hardcoding currency
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

  void updateItem(FinancialItem itemToBeUpdated, String name, double value) {
    state.maybeWhen(
      initial: (originalHoldings, updatedHoldings, saving) {
        final updated = itemToBeUpdated.copyWith(
          name: name,
          currentValue: Amount(
            currencyCode: itemToBeUpdated.currentValue.currencyCode,
            value: itemToBeUpdated.type.maybeWhen(
              liability: () => value * -1,
              orElse: () => value,
            ),
          ),
        );
        final newList = [...updatedHoldings.financialItems];
        newList.removeWhere((element) => element.id == itemToBeUpdated.id);
        newList.add(updated);
        state = (state as Initial).copyWith(
          updatedHoldings: Holdings(financialItems: newList),
        );
      },
      orElse: () {},
    );
  }

  void addNewItem(String name, double value, FiType type) {
    state.maybeWhen(
      initial: (originalHoldings, updatedHoldings, saving) {
        final List<FinancialItem> newList = [
          ...updatedHoldings.financialItems,
          FinancialItem(
            id: uuidGen.generate(),
            name: name,
            // TODO: Stop hardcoding currency
            type: type,
            currentValue: Amount(
              currencyCode: 'GBP',
              value: type.maybeWhen(
                liability: () => value * -1,
                orElse: () => value,
              ),
            ),
          ),
        ];
        state = (state as Initial).copyWith(
          updatedHoldings: Holdings(financialItems: newList),
        );
      },
      orElse: () {},
    );
  }

  Future<void> saveAllUpdates() async {
    state.maybeWhen(
      initial: (originalHoldings, updatedHoldings, saving) {
        state = (state as Initial).copyWith(saving: true);

        final List<AddUpdateItemInstruction> instructs = [];
        double assetValue = 0.0;
        double liabValue = 0.0;

        for (var item in updatedHoldings.financialItems) {
          final existing = originalHoldings.getById(item.id);
          if (existing == null) {
            instructs.add(AddUpdateItemInstruction.add(item: item));
            continue;
          }
          final nameChanged = existing.name != item.name;
          final valueChanged =
              existing.currentValue.value != item.currentValue.value;
          if (nameChanged || valueChanged) {
            final ins = AddUpdateItemInstruction.update(
              idOfItem: item.id,
              newName: nameChanged ? item.name : null,
              newValue: valueChanged ? item.currentValue.value : null,
            );
            instructs.add(ins);
          }
          item.type.when(
            account: () => assetValue += item.currentValue.value,
            physAsset: () => assetValue += item.currentValue.value,
            liability: () => liabValue += item.currentValue.value,
          );
        }
        // TODO: Stop hardcoding currency
        final newEntry = NetWorthEntry(
          id: uuidGen.generate(),
          assetsValue: Amount(currencyCode: 'GBP', value: assetValue),
          liabilitiesValue: Amount(currencyCode: 'GBP', value: liabValue),
          dateTime: DateTime.now(),
        );
        final test = 6;
        /*
          TODO:
            - Send these instructions and NWEntry to the repo
            - Update the NWManager
         */
      },
      orElse: () {},
    );
  }
}
