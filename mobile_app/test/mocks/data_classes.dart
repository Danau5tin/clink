import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/holdings.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/historical_net_worth.dart';
import 'package:clink_mobile_app/features/net_worth_tracker/domain/entities/net_worth_data.dart';
import 'package:mocktail/mocktail.dart';

class MockNetWorthData extends Mock implements NetWorthData {}

class MockHistoricalNWorthData extends Mock implements HistoricalNWorthData {}

class MockAssetsLiabilitiesHoldings extends Mock
    implements Holdings {}
