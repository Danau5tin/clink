import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/fi_type.dart';

const _accountId = 1;
const _physAssetId = 2;
const _liabId = 3;

class FITypeModel {
  static FiType fromSqlDb(int value) {
    switch (value) {
      case _accountId:
        return const FiType.account();
      case _physAssetId:
        return const FiType.physAsset();
      case _liabId:
        return const FiType.liability();
      default:
        throw UnimplementedError('Unknown type of $value');
    }
  }

  static int toSqlDb(FiType type) {
    return type.when(
      account: () => _accountId,
      physAsset: () => _physAssetId,
      liability: () => _liabId,
    );
  }
}
