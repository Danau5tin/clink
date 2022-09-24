import 'package:flutter/material.dart';

class LightRoundedContainer extends StatelessWidget {
  final Widget child;

  const LightRoundedContainer({
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 8,
            offset: const Offset(0, 2),
          )
        ],
        border: Border.all(color: Colors.grey.shade200, width: 2),
        color: Colors.white,
      ),
      child: child,
    );
  }
}
