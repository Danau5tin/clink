import 'package:clink_mobile_app/core/common/presentation/theme/colors.dart';
import 'package:flutter/material.dart';

const _txtColor = CColors.greyText;

class LightRoundedContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final double? borderRadius;

  const LightRoundedContainer({
    required this.child,
    this.padding,
    this.borderRadius,
    Key? key,
  }) : super(key: key);

  static Text builtTopTitle(BuildContext context, String title) => Text(
        title,
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
              color: _txtColor,
              fontSize: 14,
            ),
      );

  factory LightRoundedContainer.withTopRow({
    required BuildContext context,
    required String title,
    required Widget child,
    Widget? topRightWidget,
  }) {
    return LightRoundedContainer(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          topRightWidget != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [builtTopTitle(context, title), topRightWidget],
                )
              : builtTopTitle(context, title),
          const Divider(color: _txtColor, thickness: 0.9),
          child,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius ?? 20),
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
      child: padding == null
          ? child
          : Padding(
              padding: padding!,
              child: child,
            ),
    );
  }
}
