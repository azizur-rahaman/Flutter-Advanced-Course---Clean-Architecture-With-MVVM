import 'package:complete_advance_course/presentation/color_manager.dart';
import 'package:complete_advance_course/presentation/value_manager.dart';
import 'package:flutter/material.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    // main colors of the app
    primaryColor: ColorManager.primary,
    primaryColorLight: ColorManager.primary.withOpacity(0.7),
    primaryColorDark: ColorManager.darkPrimary,
    disabledColor: ColorManager.grey1, // this will be use for siabled button

    // card view theme
    cardTheme: CardTheme(
      color: ColorManager.white,
      shadowColor: ColorManager.grey,
      elevation: AppSize.s4,
    )

    // App bar theme

    // Button theme

    // Text theme

    // input description theme (text form field)
  );
}
