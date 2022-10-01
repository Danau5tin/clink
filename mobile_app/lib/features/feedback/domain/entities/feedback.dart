class Feedback {
  String feedbackText;
  String? emailOfUser;
  String userId;
  DateTime dateOfSubmission;

  Feedback({
    required this.feedbackText,
    required this.userId,
    required this.dateOfSubmission,
    this.emailOfUser,
  });
}
