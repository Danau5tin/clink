import 'package:clink_mobile_app/core/common/domain/entities/user.dart';
import 'package:clink_mobile_app/core/common/domain/misc/uuid_gen.dart';
import 'package:clink_mobile_app/core/common/domain/repositories/key_value_local_storage.dart';
import 'package:clink_mobile_app/core/crashlytics/crashlytics_reporter.dart';
import 'package:clink_mobile_app/core/feature_registration/service_locator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const _userIdKey = 'userId';
const _baseCurrKey = 'baseCurr';

final userManProv = StateNotifierProvider<UserManager, User?>(
  (ref) => UserManager(
    uuidGen: sl.get<UUIDGen>(),
    kValLocalStorage: sl.get<KeyValueLocalStorage>(),
    crashlyticsReporter: sl.get<CrashlyticsReporter>(),
  ),
);

class UserManager extends StateNotifier<User?> {
  final KeyValueLocalStorage kValLocalStorage;
  final UUIDGen uuidGen;
  final CrashlyticsReporter crashlyticsReporter;

  UserManager({
    required this.uuidGen,
    required this.kValLocalStorage,
    required this.crashlyticsReporter,
  }) : super(null);

  void init() {
    final userId = kValLocalStorage.getString(_userIdKey);
    final baseCurrency = kValLocalStorage.getString(_baseCurrKey);
    if (userId != null && baseCurrency != null) {
      state = User(id: userId, baseCurrencyCode: baseCurrency);
    } else {
      crashlyticsReporter
          .reportMessage('trying to init user but values are id=$userId '
              'and currency=$baseCurrency');
    }
  }

  Future<void> createNewUser(String baseCurrency) async {
    final user = User(id: uuidGen.generate(), baseCurrencyCode: baseCurrency);
    state = user;
    await kValLocalStorage.saveString(_userIdKey, user.id);
    await kValLocalStorage.saveString(_baseCurrKey, user.baseCurrencyCode);
  }
}
