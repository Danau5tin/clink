import 'package:clink_mobile_app/core/analytics_crashlytics/analytics_reporter.dart';
import 'package:clink_mobile_app/core/common/presentation/dynamic_sized_box.dart';
import 'package:clink_mobile_app/core/common/presentation/keypad/keypad.dart';
import 'package:clink_mobile_app/core/common/presentation/keypad/utils/keypad_entry_handler.dart';
import 'package:clink_mobile_app/core/common/presentation/light_rounded_container.dart';
import 'package:clink_mobile_app/core/common/presentation/standard_app_bar.dart';
import 'package:clink_mobile_app/core/common/presentation/theme/colors.dart';
import 'package:clink_mobile_app/core/common/presentation/tip_text.dart';
import 'package:clink_mobile_app/core/feature_registration/service_locator.dart';
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

  final AnalyticsReporter _analyticsReporter = sl.get<AnalyticsReporter>();

  final AddUpdateHoldingScreenArgs args;

   AddUpdateHoldingScreen({
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
  late final FocusNode _focusNode;

  bool _textFieldHasFocus = false;

  FiType get _type => widget.args.type;

  FinancialItem? get _itemToBeUpdated => widget.args.itemToBeUpdated;

  StandardAppBar? get _replacementAppBar => widget.args.replacementAppBar;

  String? get _tipText => widget.args.tipText;

  Function(String name, double amount)? get _onTapOverride =>
      widget.args.onTapOverride;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: _itemToBeUpdated?.name);
    _focusNode = FocusNode();

    _focusNode.addListener(() {
      setState(() {
        _textFieldHasFocus = _focusNode.hasFocus;
      });
    });

    if (_itemToBeUpdated != null) {
      ref
          .read(keypadHandlerProv.notifier)
          .inputDouble(_itemToBeUpdated!.currentValue.value);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _focusNode.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _replacementAppBar ?? _buildAppbar(context),
        body: Consumer(
          builder: (context, ref, child) {
            final keypadEntry = ref.watch(keypadHandlerProv);
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (_tipText != null) ...[
                    TipText(text: _tipText!),
                    DynamicHSizedBox.xl(),
                  ],
                  _buildNameInput,
                  const Spacer(),
                  BalanceEntryDisplay(
                    entry: keypadEntry,
                    title: _itemToBeUpdated == null
                        ? 'current_balance'.tr
                        : 'new_balance'.tr,
                    entryColor: _type.maybeWhen(
                      liability: () => Colors.red,
                      orElse: () => null,
                    ),
                    prefix: _type.maybeWhen(
                      liability: () => '-',
                      orElse: () => null,
                    ),
                  ),
                  const Spacer(),
                  Expanded(
                    flex: 6,
                    child: Keypad(
                      onTap:
                          ref.read(keypadHandlerProv.notifier).processNewInput,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => _onCTATap(ref, keypadEntry),
                    child: Text(
                      _itemToBeUpdated == null
                          ? _type.when(
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
      ),
    );
  }

  void _onCTATap(WidgetRef ref, String keypadEntry) {
    final name = _controller.text;
    final value = double.parse(keypadEntry);

    if (_onTapOverride != null) {
      _onTapOverride!.call(name, value);
      return;
    }
    if (_itemToBeUpdated == null) {
      ref.read(updateFinsManProv.notifier).addNewItem(name, value, _type);
      widget._analyticsReporter.trackEvent('add_new_confirmed');
    } else {
      ref.read(updateFinsManProv.notifier).updateItem(
            _itemToBeUpdated!,
            name,
            value,
          );
      widget._analyticsReporter.trackEvent('update_existing_confirmed');
    }
    Navigator.pop(context);
  }

  StandardAppBar _buildAppbar(BuildContext context) {
    return StandardAppBar(
      context: context,
      title: _itemToBeUpdated != null
          ? _getUpdateTxt
          : _type.when(
              account: () => 'new_account'.tr,
              physAsset: () => 'new_asset'.tr,
              liability: () => 'new_liability'.tr,
            ),
    );
  }

  String get _getUpdateTxt {
    return _type.when(
      account: () => 'update_account'.tr,
      physAsset: () => 'update_asset'.tr,
      liability: () => 'update_liability'.tr,
    );
  }

  LightRoundedContainer get _buildNameInput {
    return LightRoundedContainer(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: TextField(
        focusNode: _focusNode,
        controller: _controller,
        decoration: InputDecoration(
          suffixIcon: _textFieldHasFocus
              ? Padding(
                  padding: const EdgeInsets.only(top: 6, bottom: 6, left: 8),
                  child: GestureDetector(
                    onTap: () => _focusNode.unfocus(),
                    child: Container(
                      padding: EdgeInsets.zero,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.done,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              : null,
          border: InputBorder.none,
          label: Text(
            _type.when(
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
  final StandardAppBar? replacementAppBar;
  final String? tipText;
  final Function(String name, double amount)? onTapOverride;

  AddUpdateHoldingScreenArgs({
    required this.type,
    this.itemToBeUpdated,
    this.replacementAppBar,
    this.tipText,
    this.onTapOverride,
  });
}
