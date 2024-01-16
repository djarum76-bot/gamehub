import 'package:flutter/material.dart';
import 'package:gamehub/main.dart';

extension CustomMediaQuery on num {
  double get h => MediaQuery.of(navigatorKey.currentContext!).size.height * this / 100;
  double get w => MediaQuery.of(navigatorKey.currentContext!).size.width * this / 100;
  double get sp => MediaQuery.of(navigatorKey.currentContext!).textScaleFactor * this;
}