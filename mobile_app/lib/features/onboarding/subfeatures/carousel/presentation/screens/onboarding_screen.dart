import 'package:clink_mobile_app/features/onboarding/subfeatures/carousel/presentation/widgets/carousel_utils/carousel_item.dart';
import 'package:clink_mobile_app/features/onboarding/subfeatures/carousel/presentation/widgets/mock_onboarding_items_column.dart';
import 'package:clink_mobile_app/features/onboarding/subfeatures/currency_select/presentation/screens/currency_select_screen.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:clink_mobile_app/core/common/presentation/dynamic_sized_box.dart';
import 'package:clink_mobile_app/core/translations/translation_provider.dart';
import 'package:easy_localization/easy_localization.dart'
    hide StringTranslateExtension;

const _defaultCurrency = 'GBP';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _idxItemCurrentlyShowing = 0;

  @override
  Widget build(BuildContext context) {
    final usersPredictedCurrency =
        NumberFormat.simpleCurrency(locale: context.locale.languageCode)
                .currencyName ??
            _defaultCurrency;

    final carouselItems = _buildDisplayWidgets(usersPredictedCurrency);
    return Scaffold(
      body: Padding(
        padding: _buildVertPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Spacer(),
            _buildCarouselSlider(context, carouselItems),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildDots(carouselItems),
            ),
            DynamicHSizedBox.l(),
            Padding(
              padding: _buildHorizPadding,
              child: ElevatedButton(
                onPressed: () => Navigator.pushNamed(
                  context,
                  CurrencySelectScreen.viewPath,
                    arguments: usersPredictedCurrency,
                ),
                child: Text('get_started'.tr),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  CarouselSlider _buildCarouselSlider(
    BuildContext context,
    List<CarouselItem> carouselItems,
  ) {
    return CarouselSlider(
      items: carouselItems
          .map(
            (currentItem) => Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .4,
                  child: currentItem.displayWidget,
                ),
                DynamicHSizedBox.xs(),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .5,
                  child: Text(
                    currentItem.explanationText,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              ],
            ),
          )
          .toList(),
      options: CarouselOptions(
        height: MediaQuery.of(context).size.height * .5,
        enableInfiniteScroll: false,
        viewportFraction: 0.98,
        autoPlay: true,
        onPageChanged: (index, reason) {
          setState(() => _idxItemCurrentlyShowing = index);
        },
      ),
    );
  }

  List<Widget> _buildDots(List<CarouselItem> items) {
    final List<Widget> widgets = [];
    for (var i = 0; i < items.length; i++) {
      final dot = Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Container(
          height: 8,
          width: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _idxItemCurrentlyShowing == i
                ? Theme.of(context).primaryColor
                : Colors.grey,
          ),
        ),
      );
      widgets.add(dot);
    }
    return widgets;
  }

  EdgeInsets get _buildVertPadding =>
      const EdgeInsets.symmetric(vertical: 20.0);

  EdgeInsets get _buildHorizPadding =>
      const EdgeInsets.symmetric(horizontal: 20.0);

  List<CarouselItem> _buildDisplayWidgets(String usersCurrency) {
    return [
      CarouselItem(
        displayWidget: MockOnboardingItemsColumn(
          usersCurrency: usersCurrency,
        ),
        explanationText: 'manage_and_update_your_finances'.tr,
      ),
      CarouselItem(
        displayWidget: Image.asset(
          'assets/images/graph_screenshot.png',
          height: 100,
        ),
        explanationText: 'easily_track_your_progress'.tr,
      ),
    ];
  }
}
