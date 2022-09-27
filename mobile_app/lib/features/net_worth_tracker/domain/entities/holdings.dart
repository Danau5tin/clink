import 'fi_type.dart';
import 'financial_item.dart';
// ignore:depend_on_referenced_packages
import 'package:collection/collection.dart';

class Holdings {
  final List<FinancialItem> financialItems;

  Holdings({
    required this.financialItems,
  });

  FinancialItem? getById(String id) {
    return financialItems.firstWhereOrNull((element) => element.id == id);
  }

  List<FinancialItem> get getAllAccounts =>
      financialItems.where((element) => element.type is Account).toList();

  List<FinancialItem> get getAllPhysAssets =>
      financialItems.where((element) => element.type is PhysicalAsset).toList();

  List<FinancialItem> get getAllLiabilities =>
      financialItems.where((element) => element.type is Liability).toList();

  double get totalValue => valueOfItems(financialItems);

  double valueOfItems(List<FinancialItem> items) {
    double count = 0.0;
    for (var i in items) {
      count += i.currentValue.value;
    }
    return count;
  }
}
