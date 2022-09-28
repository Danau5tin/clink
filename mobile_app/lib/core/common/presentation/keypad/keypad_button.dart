import 'package:clink_mobile_app/core/common/presentation/keypad/keypad_entry.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class KeypadButton extends StatelessWidget {
  final KeypadEntry entry;
  final Function(KeypadEntry) onTap;

  const KeypadButton({
    required this.entry,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(entry),
      child: Center(
        child: entry.when(
          digit: (digit) => Text(digit.toString(), style: _textStyle(context)),
          decimal: () => _buildDecimalPoint(context),
          backspace: () => Icon(
            Icons.backspace_outlined,
            color: _color(context),
          ),
        ),
      ),
    );
  }

  Text _buildDecimalPoint(BuildContext context) {
    final formattedNum = NumberFormat.simpleCurrency(
      name: '',
      locale: context.locale.languageCode,
    ).format(1.1);
    final decimalDelimiter = RegExp('[.|,]').firstMatch(formattedNum);
    return Text(
      decimalDelimiter?.group(0) ?? ',',
      style: _textStyle(context),
    );
  }

  TextStyle _textStyle(BuildContext context) {
    return Theme.of(context).textTheme.headline5!.copyWith(
      fontWeight: FontWeight.w400,
          color: _color(context),
        );
  }

  Color _color(BuildContext context) =>
      Theme.of(context).primaryColor.withOpacity(0.9);
}
