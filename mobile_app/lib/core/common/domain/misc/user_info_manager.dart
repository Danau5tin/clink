import 'package:clink_mobile_app/core/analytics_crashlytics/analytics_reporter.dart';
import 'package:clink_mobile_app/core/common/domain/entities/user.dart';
import 'package:clink_mobile_app/core/common/domain/misc/uuid_gen.dart';
import 'package:clink_mobile_app/core/common/domain/repositories/key_value_local_storage.dart';
import 'package:clink_mobile_app/core/analytics_crashlytics/crashlytics_reporter.dart';
import 'package:clink_mobile_app/core/feature_registration/service_locator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const _userIdKey = 'userId';
const _baseCurrKey = 'baseCurr';

const _defaultCurrency = 'GBP';

final userManProv = StateNotifierProvider<UserManager, User?>(
  (ref) => sl.get<UserManager>(),
);

class UserManager extends StateNotifier<User?> {
  final KeyValueLocalStorage kValLocalStorage;
  final UUIDGen uuidGen;
  final CrashlyticsReporter crashlyticsReporter;
  final AnalyticsReporter analyticsReporter;

  UserManager({
    required this.uuidGen,
    required this.kValLocalStorage,
    required this.crashlyticsReporter,
    required this.analyticsReporter,
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
    analyticsReporter.identifyUser(id: user.id);
    crashlyticsReporter.identifyUser(userId: user.id);
    await kValLocalStorage.saveString(_userIdKey, user.id);
    await kValLocalStorage.saveString(_baseCurrKey, user.baseCurrencyCode);
  }

  User? get user => state;

  String get usersBaseCurrency => user?.baseCurrencyCode ?? _defaultCurrency;
}
