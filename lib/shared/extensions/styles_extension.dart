import 'package:flutter/material.dart';
import 'package:gamehub/themes/app_colors_style.dart';

extension ColorsExtension on BuildContext {
  AppColorsExtension get appColors => Theme.of(this).extension<AppColorsExtension>()!;
}