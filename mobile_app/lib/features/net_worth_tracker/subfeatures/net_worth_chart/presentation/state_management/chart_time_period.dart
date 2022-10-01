import 'package:clink_mobile_app/core/translations/translation_provider.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chart_time_period.freezed.dart';

@freezed
class ChartTimePeriod with _$ChartTimePeriod {
  const ChartTimePeriod._();

  const factory ChartTimePeriod.today() = Today;

  const factory ChartTimePeriod.oneWeek() = OneWeek;

  const factory ChartTimePeriod.oneMonth() = OneMonth;

  const factory ChartTimePeriod.threeMonths() = ThreeMonths;

  const factory ChartTimePeriod.sixMonths() = SixMonths;

  const factory ChartTimePeriod.oneYear() = OneYear;

  DateTime get relevantDate {
    final now = DateTime.now();
    return when(
      today: () => DateTime(now.year, now.month, now.day),
      oneWeek: () => now.subtract(const Duration(days: 7)),
      oneMonth: () => now.subtract(const Duration(days: 30)),
      threeMonths: () => now.subtract(const Duration(days: 90)),
      sixMonths: () => now.subtract(const Duration(days: 180)),
      oneYear: () => now.subtract(const Duration(days: 365)),
    );
  }

  @override
  String toString() {
    return when(
      today: () => '1${'day'.tr[0]}',
      oneWeek: () => '1${'week'.tr[0]}',
      oneMonth: () => '1${'month'.tr[0]}',
      threeMonths: () => '3${'month'.tr[0]}',
      sixMonths: () => '6${'month'.tr[0]}',
      oneYear: () => '1${'year'.tr[0]}',
    );
  }
}
