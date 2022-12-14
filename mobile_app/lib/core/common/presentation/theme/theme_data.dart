import 'package:clink_mobile_app/core/common/presentation/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const _primaryColor = Color(0xff4255f0);
const _standardTextColor = Colors.black;
final textTheme = GoogleFonts.interTextTheme();

ThemeData get appTheme {
  return ThemeData(
    primaryColor: _primaryColor,
    elevatedButtonTheme: _buildElevatedButtonThemeData,
    scaffoldBackgroundColor: Colors.white,
    textTheme: _buildTextTheme(textTheme),
    appBarTheme: _buildAppBarTheme,
  );
}

AppBarTheme get _buildAppBarTheme {
  return AppBarTheme(
    centerTitle: true,
    backgroundColor: Colors.white,
    elevation: 0,
    titleTextStyle: _buildTextTheme(textTheme).bodyText1,
    iconTheme: const IconThemeData(
      color: _primaryColor,
    ),
  );
}

ElevatedButtonThemeData get _buildElevatedButtonThemeData {
  return ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(_primaryColor),
      padding: MaterialStateProperty.all(const EdgeInsets.all(16)),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      elevation: MaterialStateProperty.all(8),
      textStyle:
          MaterialStateProperty.all(_buildTextTheme(textTheme).bodyText1),
    ),
  );
}

TextTheme _buildTextTheme(TextTheme textTheme) {
  return textTheme.copyWith(
    headline1: textTheme.headline1!.copyWith(
      color: _standardTextColor,
      fontSize: 32,
      fontWeight: FontWeight.bold,
    ),
    headline2: textTheme.headline2!.copyWith(
      color: _standardTextColor,
      fontSize: 28,
      fontWeight: FontWeight.bold,
    ),
    headline3: textTheme.headline3!.copyWith(color: _standardTextColor),
    headline4: textTheme.headline4!.copyWith(color: _standardTextColor),
    headline5: textTheme.headline5!.copyWith(
      color: _standardTextColor,
      fontWeight: FontWeight.w600,
    ),
    headline6: textTheme.headline6!.copyWith(color: _standardTextColor),
    bodyText1: textTheme.bodyText1!.copyWith(
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
    caption: const TextStyle(
      color: CColors.greyText,
      fontSize: 16,
    ),
  );
}
