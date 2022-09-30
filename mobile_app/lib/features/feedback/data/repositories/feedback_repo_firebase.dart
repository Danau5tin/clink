import 'package:clink_mobile_app/core/network/data_state/data_state.dart';
import 'package:clink_mobile_app/features/feedback/data/models/feedback_model.dart';
import 'package:clink_mobile_app/features/feedback/domain/entities/feedback.dart';
import 'package:clink_mobile_app/features/feedback/domain/repositories/feedback_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FeedbackRepoFirebase implements FeedbackRepo {
  final CollectionReference _feedbackCollection =
      FirebaseFirestore.instance.collection('feedback');

  @override
  Future<DataState<bool, void>> submitFeedback(Feedback feedback) async {
    final feedbackModel = FeedbackModel.fromFeedback(feedback);
    try {
      await _feedbackCollection.add(feedbackModel.toMap());
      return const DataState.success(true);
    } on FirebaseException catch (e) {
      return DataState.failure(exception: e);
    }
  }
}
