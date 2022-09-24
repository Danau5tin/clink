import 'package:flutter/material.dart';

class DynamicHSizedBox extends StatelessWidget {
  final double _heightMultiplier;

  const DynamicHSizedBox({
    required double heightMultiplier,
    Key? key,
  })  : _heightMultiplier = heightMultiplier,
        super(key: key);

  factory DynamicHSizedBox.xxs() =>
      const DynamicHSizedBox(heightMultiplier: 0.005);

  factory DynamicHSizedBox.xs() =>
      const DynamicHSizedBox(heightMultiplier: 0.007);

  factory DynamicHSizedBox.s() =>
      const DynamicHSizedBox(heightMultiplier: 0.013);

  factory DynamicHSizedBox.m() =>
      const DynamicHSizedBox(heightMultiplier: 0.02);

  factory DynamicHSizedBox.l() =>
      const DynamicHSizedBox(heightMultiplier: 0.03);

  factory DynamicHSizedBox.xl() =>
      const DynamicHSizedBox(heightMultiplier: 0.04);

  factory DynamicHSizedBox.xxl() =>
      const DynamicHSizedBox(heightMultiplier: 0.08);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * _heightMultiplier,
    );
  }
}

class DynamicWSizedBox extends StatelessWidget {
  final double _widthMultiplier;

  const DynamicWSizedBox({
    required double widthMultiplier,
    Key? key,
  })  : _widthMultiplier = widthMultiplier,
        super(key: key);

  factory DynamicWSizedBox.xxs() =>
      const DynamicWSizedBox(widthMultiplier: 0.005);

  factory DynamicWSizedBox.xs() =>
      const DynamicWSizedBox(widthMultiplier: 0.010);

  factory DynamicWSizedBox.s() =>
      const DynamicWSizedBox(widthMultiplier: 0.025);

  factory DynamicWSizedBox.m() =>
      const DynamicWSizedBox(widthMultiplier: 0.038);

  factory DynamicWSizedBox.l() => const DynamicWSizedBox(widthMultiplier: 0.08);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * _widthMultiplier,
    );
  }
}
