import 'fi_type.dart';
import 'financial_item.dart';

class AssetsLiabilitiesHoldings {
  final List<FinancialItem> financialItems;

  AssetsLiabilitiesHoldings({
    required this.financialItems,
  });

  List<FinancialItem> get getAllAccounts =>
      financialItems.where((element) => element.type is Account).toList();

  List<FinancialItem> get getAllPhysAssets =>
      financialItems.where((element) => element.type is PhysicalAsset).toList();

  List<FinancialItem> get getAllLiabilities =>
      financialItems.where((element) => element.type is Liability).toList();

  double valueOfItems(List<FinancialItem> items) {
    double count = 0.0;
    for (var i in items) {
      count += i.historicalValues.last.amount.value;
    }
    return count;
  }
}
