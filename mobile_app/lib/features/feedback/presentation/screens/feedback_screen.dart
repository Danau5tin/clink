import 'package:clink_mobile_app/core/common/presentation/circular_progress_bar.dart';
import 'package:clink_mobile_app/core/common/presentation/dynamic_sized_box.dart';
import 'package:clink_mobile_app/core/common/presentation/errors/something_went_wrong_column.dart';
import 'package:clink_mobile_app/core/common/presentation/go_back_button.dart';
import 'package:clink_mobile_app/core/common/presentation/light_rounded_container.dart';
import 'package:clink_mobile_app/core/common/presentation/standard_app_bar.dart';
import 'package:clink_mobile_app/core/common/presentation/tip_text.dart';
import 'package:clink_mobile_app/core/translations/translation_provider.dart';
import 'package:clink_mobile_app/features/feedback/navigation/feedback_nav_handler.dart';
import 'package:clink_mobile_app/features/feedback/presentation/state_management/feedback_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FeedbackScreen extends StatefulWidget {
  static const viewPath = '${FeedbackNavHandler.startingPath}/textInput';

  const FeedbackScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final TextEditingController _feedbackController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _feedbackController.dispose();
    _emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StandardAppBar(
        context: context,
        title: 'feedback_and_features'.tr,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Consumer(
          builder: (context, ref, child) {
            final feedbackState = ref.watch(feedbackManProv);
            return feedbackState.when(
              initial: (submitting) => _buildMainUi(submitting, ref),
              error: () => const SomethingWentWrongColumn(),
              success: () => _buildSuccessUi(context),
            );
          },
        ),
      ),
    );
  }

  Widget _buildMainUi(bool submitting, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TipText(text: 'tell_us_how_to_be_valuable_to_you'.tr),
        DynamicHSizedBox.xl(),
        Expanded(
          child: LightRoundedContainer(
            padding: EdgeInsets.all(_inputHorizPadding),
            child: TextField(
              controller: _feedbackController,
              decoration: InputDecoration(
                hintText: 'type_here'.tr,
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        DynamicHSizedBox.s(),
        LightRoundedContainer(
          padding: EdgeInsets.symmetric(
            vertical: 4,
            horizontal: _inputHorizPadding,
          ),
          child: TextField(
            controller: _emailController,
            decoration: InputDecoration(
              label: Text('email_optional'.tr),
              border: InputBorder.none,
            ),
          ),
        ),
        DynamicHSizedBox.xl(),
        submitting
            ? const CircularProgressBar()
            : ElevatedButton(
                onPressed: () =>
                    ref.read(feedbackManProv.notifier).submitFeedback(
                          _feedbackController.text,
                          _emailController.text,
                        ),
                child: Text('send_to_us'.tr),
              )
      ],
    );
  }

  double get _inputHorizPadding => 12;

  Center _buildSuccessUi(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('🤩', style: TextStyle(fontSize: 50)),
          DynamicHSizedBox.m(),
          Text(
            'success_!'.tr,
            style: Theme.of(context).textTheme.headline2,
          ),
          DynamicHSizedBox.s(),
          Text(
            'thank_you_we_will_take_a_look_shortly'.tr,
            textAlign: TextAlign.center,
          ),
          DynamicHSizedBox.xl(),
          const GoBackButton(),
        ],
      ),
    );
  }
}
