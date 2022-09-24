import 'package:freezed_annotation/freezed_annotation.dart';

part 'fi_type.freezed.dart';

@freezed
class FiType with _$FiType {
  const factory FiType.account() = Account;

  const factory FiType.physicalAsset() = PhysicalAsset;

  const factory FiType.liability() = Liability;
}
