import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/fi_type.dart';

class FITypeModel {
  static FiType fromSqlDb(int value) {
    switch (value) {
      case 1:
        return const FiType.account();
      case 2:
        return const FiType.physicalAsset();
      case 3:
        return const FiType.liability();
      default:
        throw UnimplementedError('Unknown type of $value');
    }
  }
}
