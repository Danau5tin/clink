import 'package:clink_mobile_app/core/common/presentation/dynamic_sized_box.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CurrencyOptionTile extends StatelessWidget {
  final String currencyCode;
  final bool selected;
  final bool addTopPadding;
  final Function(String currencyCode) onTap;

  const CurrencyOptionTile({
    required this.addTopPadding,
    required this.currencyCode,
    required this.selected,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const padd = 12.0;
    return GestureDetector(
      onTap: () => onTap(currencyCode),
      child: Container(
        decoration: BoxDecoration(
          color: selected
              ? Theme.of(context).primaryColor
              : Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
        margin: addTopPadding
            ? const EdgeInsets.only(top: padd, left: padd, right: padd)
            : const EdgeInsets.symmetric(horizontal: padd),
        padding: const EdgeInsets.all(padd),
        child: Row(
          children: [
            Text(_currencyToEmoji, style: const TextStyle(fontSize: 32)),
            DynamicWSizedBox.s(),
            Text(currencyCode, style: _textTheme(context)),
            const Spacer(),
            Text(
              NumberFormat.simpleCurrency(name: currencyCode).currencySymbol,
              style: _textTheme(context),
            )
          ],
        ),
      ),
    );
  }

  TextStyle _textTheme(BuildContext context) {
    return Theme.of(context).textTheme.bodyText1!.copyWith(
          color: selected ? Colors.white : Colors.black,
          fontSize: 20,
        );
  }

  String get _currencyToEmoji {
    final int firstLetter = currencyCode.codeUnitAt(0) - 0x41 + 0x1F1E6;
    final int secondLetter = currencyCode.codeUnitAt(1) - 0x41 + 0x1F1E6;
    return String.fromCharCode(firstLetter) + String.fromCharCode(secondLetter);
  }
}
