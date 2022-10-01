import 'package:clink_mobile_app/features/feedback/domain/entities/feedback.dart';

class FeedbackModel extends Feedback {
  FeedbackModel({
    required super.feedbackText,
    required super.userId,
    required super.dateOfSubmission,
    super.emailOfUser,
  });

  factory FeedbackModel.fromFeedback(Feedback feedback) {
    return FeedbackModel(
      feedbackText: feedback.feedbackText,
      emailOfUser: feedback.emailOfUser,
      userId: feedback.userId,
      dateOfSubmission: feedback.dateOfSubmission,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'text': feedbackText,
      'userEmail': emailOfUser,
      'userId': userId,
      'dateTime': dateOfSubmission.millisecondsSinceEpoch,
    };
  }
}
