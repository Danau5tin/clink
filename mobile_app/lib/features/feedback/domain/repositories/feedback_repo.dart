import 'package:clink_mobile_app/core/network/data_state/data_state.dart';
import 'package:clink_mobile_app/features/feedback/domain/entities/feedback.dart';

abstract class FeedbackRepo {
  Future<DataState<bool, void>> submitFeedback(Feedback feedback);
}