import 'package:clink_mobile_app/core/translations/translation_provider.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'fi_type.freezed.dart';

@freezed
class FiType with _$FiType {
  const FiType._();

  const factory FiType.account() = Account;

  const factory FiType.physAsset() = PhysicalAsset;

  const factory FiType.liability() = Liability;

  @override
  String toString() {
    return when(
      account: () => 'accounts'.tr,
      physAsset: () => 'physical_assets'.tr,
      liability: () => 'liabilities'.tr,
    );
  }
}
