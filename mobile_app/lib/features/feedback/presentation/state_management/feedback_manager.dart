import 'package:clink_mobile_app/core/analytics_crashlytics/analytics_reporter.dart';
import 'package:clink_mobile_app/core/common/domain/misc/user_info_manager.dart';
import 'package:clink_mobile_app/core/analytics_crashlytics/crashlytics_reporter.dart';
import 'package:clink_mobile_app/core/feature_registration/service_locator.dart';
import 'package:clink_mobile_app/features/feedback/domain/entities/feedback.dart';
import 'package:clink_mobile_app/features/feedback/domain/repositories/feedback_repo.dart';
import 'package:clink_mobile_app/features/feedback/presentation/state_management/feedback_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final feedbackManProv =
    StateNotifierProvider.autoDispose<FeedbackManager, FeedbackState>(
  (ref) => FeedbackManager(
    userManager: sl.get<UserManager>(),
    feedbackRepo: sl.get<FeedbackRepo>(),
    crashlyticsReporter: sl.get<CrashlyticsReporter>(),
    analyticsReporter: sl.get<AnalyticsReporter>(),
  ),
);

class FeedbackManager extends StateNotifier<FeedbackState> {
  final UserManager userManager;
  final FeedbackRepo feedbackRepo;
  final CrashlyticsReporter crashlyticsReporter;
  final AnalyticsReporter analyticsReporter;

  FeedbackManager({
    required this.userManager,
    required this.feedbackRepo,
    required this.crashlyticsReporter,
    required this.analyticsReporter,
  }) : super(const FeedbackState.initial());

  Future<void> submitFeedback(String feedbackText, String? userEmail) async {
    await state.maybeWhen(
      initial: (submitting) async {
        state = (state as Initial).copyWith(submitting: true);
        final feedback = Feedback(
          feedbackText: feedbackText,
          emailOfUser: userEmail,
          userId: userManager.user!.id,
          dateOfSubmission: DateTime.now(),
        );
        final res = await feedbackRepo.submitFeedback(feedback);
        res.when(
          success: (data) {
            state = const FeedbackState.success();
            analyticsReporter.trackEvent('give_feedback_sent');
          },
          failure: (failureInfo, exception) {
            state = const FeedbackState.error();
            crashlyticsReporter.reportException(exception);
          },
        );
      },
      orElse: () async => crashlyticsReporter.reportMessage(
        'Trying to submit feedback when state = $state',
      ),
    );
  }
}
