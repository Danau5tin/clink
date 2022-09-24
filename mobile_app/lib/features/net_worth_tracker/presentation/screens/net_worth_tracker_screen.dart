import 'package:clink_mobile_app/features/net_worth_tracker/navigation/net_worth_tracker_nav_handler.dart';
import 'package:flutter/material.dart';

class NetWorthTrackerScreen extends StatelessWidget {
  static const String viewPath =
      '${NetWorthTrackerNavHandler.startingPath}/dash';

  const NetWorthTrackerScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [Text('£13,127.99')],
      ),
    );
  }
}
