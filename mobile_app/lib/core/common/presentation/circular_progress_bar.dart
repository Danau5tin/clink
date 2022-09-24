import 'package:flutter/material.dart';

class CircularProgressBar extends StatelessWidget {
  final Color? _color;
  final bool _centered;
  final double strokeWidth;

  const CircularProgressBar({
    Color? color,
    bool centered = true,
    this.strokeWidth = 2,
    Key? key,
  })  : _color = color,
        _centered = centered,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final indicator = _buildCircularProgressIndicator(context);
    return _centered ? Center(child: indicator) : indicator;
  }

  CircularProgressIndicator _buildCircularProgressIndicator(
    BuildContext context,
  ) {
    return CircularProgressIndicator(
      strokeWidth: strokeWidth,
      valueColor: AlwaysStoppedAnimation<Color>(
        _color ?? Theme.of(context).primaryColor,
      ),
    );
  }
}
