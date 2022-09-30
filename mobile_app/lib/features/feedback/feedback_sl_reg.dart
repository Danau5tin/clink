import 'package:clink_mobile_app/core/feature_registration/abstract/feature_sl_reg.dart';
import 'package:clink_mobile_app/features/feedback/data/repositories/feedback_repo_firebase.dart';
import 'package:clink_mobile_app/features/feedback/domain/repositories/feedback_repo.dart';
import 'package:get_it/get_it.dart';

class FeedbackSlReg extends FeatureSlReg {
  @override
  void registerObjects(GetIt instance) {
    instance.registerLazySingleton<FeedbackRepo>(
      () => FeedbackRepoFirebase(),
    );
  }
}
