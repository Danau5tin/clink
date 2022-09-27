import 'package:clink_mobile_app/core/common/presentation/keypad/keypad.dart';
import 'package:clink_mobile_app/core/common/presentation/keypad/utils/keypad_entry_handler.dart';
import 'package:clink_mobile_app/core/common/presentation/light_rounded_container.dart';
import 'package:clink_mobile_app/core/common/presentation/standard_app_bar.dart';
import 'package:clink_mobile_app/core/common/presentation/theme/colors.dart';
import 'package:clink_mobile_app/core/translations/translation_provider.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/fi_type.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/financial_item.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/navigation/net_worth_tracker_nav_handler.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/subfeatures/add_update_holding/presentation/widgets/balance_entry_display.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/subfeatures/update_n_worth/presentation/state_management/update_financials_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddUpdateHoldingScreen extends ConsumerStatefulWidget {
  static const viewPath =
      '${NetWorthTrackerNavHandler.startingPath}/addUpdateHolding';

  final AddUpdateHoldingScreenArgs args;

  const AddUpdateHoldingScreen({
    required this.args,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<AddUpdateHoldingScreen> createState() =>
      _AddUpdateHoldingScreenState();
}

class _AddUpdateHoldingScreenState
    extends ConsumerState<AddUpdateHoldingScreen> {
  late final TextEditingController _controller;

  FiType get type => widget.args.type;

  FinancialItem? get itemToBeUpdated => widget.args.itemToBeUpdated;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: itemToBeUpdated?.name);
    if (itemToBeUpdated != null) {
      ref
          .read(keypadHandlerProv.notifier)
          .inputDouble(itemToBeUpdated!.currentValue.value);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(context),
      body: Consumer(
        builder: (context, ref, child) {
          final keypadEntry = ref.watch(keypadHandlerProv);
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildNameInput,
                const Spacer(),
                BalanceEntryDisplay(
                  entry: keypadEntry,
                  title: itemToBeUpdated == null
                      ? 'current_balance'.tr
                      : 'new_balance'.tr,
                  entryColor: type.maybeWhen(
                    liability: () => Colors.red,
                    orElse: () => null,
                  ),
                  prefix: type.maybeWhen(
                    liability: () => '-',
                    orElse: () => null,
                  ),
                ),
                const Spacer(),
                Expanded(
                  flex: 6,
                  child: Keypad(
                    onTap: ref.read(keypadHandlerProv.notifier).processNewInput,
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _onCTATap(ref, keypadEntry),
                  child: Text(
                    itemToBeUpdated == null
                        ? type.when(
                            account: () => 'add_new_account'.tr,
                            physAsset: () => 'add_new_asset'.tr,
                            liability: () => 'add_new_liability'.tr,
                          )
                        : _getUpdateTxt,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  void _onCTATap(WidgetRef ref, String keypadEntry) {
    if (itemToBeUpdated == null) {
      ref.read(updateFinsManProv.notifier).addNewItem(
            _controller.text,
            double.parse(keypadEntry),
            type,
          );
    } else {
      ref.read(updateFinsManProv.notifier).updateItem(
            itemToBeUpdated!,
            _controller.text,
            double.parse(keypadEntry),
          );
    }
    Navigator.pop(context);
  }

  StandardAppBar _buildAppbar(BuildContext context) {
    return StandardAppBar(
      context: context,
      title: itemToBeUpdated != null
          ? _getUpdateTxt
          : type.when(
              account: () => 'new_account'.tr,
              physAsset: () => 'new_asset'.tr,
              liability: () => 'new_liability'.tr,
            ),
    );
  }

  String get _getUpdateTxt {
    return type.when(
      account: () => 'update_account'.tr,
      physAsset: () => 'update_asset'.tr,
      liability: () => 'update_liability'.tr,
    );
  }

  LightRoundedContainer get _buildNameInput {
    return LightRoundedContainer(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: TextField(
        controller: _controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          label: Text(
            type.when(
              account: () => 'account_name'.tr,
              physAsset: () => 'asset_name'.tr,
              liability: () => 'liability_name'.tr,
            ),
          ),
          labelStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: CColors.greyText,
                fontSize: 13,
              ),
        ),
      ),
    );
  }
}

class AddUpdateHoldingScreenArgs {
  final FiType type;
  final FinancialItem? itemToBeUpdated;

  AddUpdateHoldingScreenArgs({
    required this.type,
    this.itemToBeUpdated,
  });
}
