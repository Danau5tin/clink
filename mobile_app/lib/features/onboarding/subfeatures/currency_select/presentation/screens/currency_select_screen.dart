import 'package:clink_mobile_app/core/analytics_crashlytics/analytics_reporter.dart';
import 'package:clink_mobile_app/core/common/domain/misc/user_info_manager.dart';
import 'package:clink_mobile_app/core/common/presentation/dynamic_sized_box.dart';
import 'package:clink_mobile_app/core/common/presentation/light_rounded_container.dart';
import 'package:clink_mobile_app/core/common/presentation/standard_app_bar.dart';
import 'package:clink_mobile_app/core/common/presentation/tip_text.dart';
import 'package:clink_mobile_app/core/feature_registration/service_locator.dart';
import 'package:clink_mobile_app/core/translations/translation_provider.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/fi_type.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/subfeatures/add_update_holding/presentation/screens/add_update_holding_screen.dart';
import 'package:clink_mobile_app/features/onboarding/navigation/onboarding_nav_handler.dart';
import 'package:clink_mobile_app/features/onboarding/subfeatures/carousel/presentation/state_management/onboarding_manager.dart';
import 'package:clink_mobile_app/features/onboarding/subfeatures/currency_select/presentation/widgets/currency_option_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CurrencySelectScreen extends StatefulWidget {
  static const viewPath = '${OnboardingNavHandler.startingPath}/currencySelect';

  final String usersPredictedCurrency;

  const CurrencySelectScreen({
    required this.usersPredictedCurrency,
    Key? key,
  }) : super(key: key);

  @override
  State<CurrencySelectScreen> createState() => _CurrencySelectScreenState();
}

class _CurrencySelectScreenState extends State<CurrencySelectScreen> {
  late String _selectedCurrency;

  late List<String> _allCurrencies;

  final AnalyticsReporter _analyticsReporter = sl.get<AnalyticsReporter>();

  @override
  void initState() {
    super.initState();
    _selectedCurrency = widget.usersPredictedCurrency;
    _allCurrencies = [..._supportedCurrencies];
    _allCurrencies
        .removeWhere((element) => element == widget.usersPredictedCurrency);
    _allCurrencies.insert(0, widget.usersPredictedCurrency);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Consumer(
            builder: (context, ref, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(child: _buildTitle(context)),
                  DynamicHSizedBox.xl(),
                  TipText(text: 'tip_choose_your_daily_life_currency'.tr),
                  DynamicHSizedBox.xl(),
                  Expanded(child: _buildCurrencyLView),
                  DynamicHSizedBox.l(),
                  ElevatedButton(
                    onPressed: () => _onContinueTap(ref, context),
                    child: Text('continue'.tr),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Text _buildTitle(BuildContext context) {
    return Text(
      'choose_your_currency'.tr,
      style: Theme.of(context).textTheme.headline1,
    );
  }

  LightRoundedContainer get _buildCurrencyLView {
    return LightRoundedContainer(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: _allCurrencies.length,
        itemBuilder: (context, index) => CurrencyOptionTile(
          currencyCode: _allCurrencies[index],
          selected: _selectedCurrency == _allCurrencies[index],
          addTopPadding: index == 0,
          onTap: (currencyCode) {
            setState(
              () => _selectedCurrency = _allCurrencies[index],
            );
            _analyticsReporter.trackEvent('currency_tapped');
          },
        ),
      ),
    );
  }

  void _onContinueTap(WidgetRef ref, BuildContext context) {
    ref.read(userManProv.notifier).createNewUser(_selectedCurrency);
    _analyticsReporter.trackEvent('currency_tapped');
    Navigator.pushNamed(
      context,
      AddUpdateHoldingScreen.viewPath,
      arguments: AddUpdateHoldingScreenArgs(
        type: const FiType.account(),
        tipText: 'input_name_and_balance_of_a_bank_account'.tr,
        replacementAppBar: StandardAppBar(
          context: context,
          title: 'add_an_account'.tr,
          largeTitle: true,
        ),
        onTapOverride: (name, amount) {
          ref.read(onboardingManProv.notifier).onboardWithNewAccount(
                name,
                amount,
              );
          Navigator.popUntil(context, (route) => route.isFirst);
          _analyticsReporter.trackEvent(
            'first_account_added',
            data: {
              'name': name,
              'balance': amount,
            },
          );
        },
      ),
    );
  }
}

const _supportedCurrencies = [
  'GBP',
  'USD',
  'EUR',
  'AUD',
  'CAD',
  'JPY',
  'CHF',
  'CNY',
  'HKD',
  'NZD',
  'SEK',
  'KRW',
  'SGD',
  'NOK',
  'MXN',
  'INR',
  'RUB',
  'ZAR',
  'TRY',
  'BRL',
  'TWD',
  'DKK',
  'PLN',
  'THB',
  'IDR',
  'HUF'
];
