import 'package:clink_mobile_app/core/common/presentation/theme/colors.dart';
import 'package:flutter/material.dart';

const _txtColor = CColors.greyText;

class LightRoundedContainer extends StatelessWidget {
  final Widget child;

  const LightRoundedContainer({
    required this.child,
    Key? key,
  }) : super(key: key);

  static Text builtTopLeftTitle(BuildContext context, String title) => Text(
        title,
        style: Theme.of(context).textTheme.bodyText2!.copyWith(
              color: _txtColor,
              fontWeight: FontWeight.w500,
            ),
      );

  factory LightRoundedContainer.withTopRow({
    required BuildContext context,
    required String title,
    required Widget child,
    Widget? topRightWidget,
  }) {
    return LightRoundedContainer(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            topRightWidget != null
                ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      builtTopLeftTitle(context, title),
                      topRightWidget
                    ],
                  )
                : builtTopLeftTitle(context, title),
            const Divider(color: _txtColor, thickness: 0.9),
            child,
          ],
        ),
      ),
    );
  }

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
