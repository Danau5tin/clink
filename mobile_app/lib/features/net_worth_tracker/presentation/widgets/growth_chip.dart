import 'package:flutter/material.dart';

class GrowthChip extends StatelessWidget {
  const GrowthChip({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.green.withOpacity(0.3),
      ),
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Text(
        '+€127.32 (+8.94%)', // TODO: Mocked data
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontSize: 11,
              color: Colors.green,
            ),
      ),
    );
  }
}
