import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppColors {
  static Color element_Fire = Color.fromARGB(255, 255, 135, 135);
  static Color element_Ice = Color.fromARGB(255, 126, 206, 246);
  static Color element_Earth = Color.fromARGB(255, 121, 239, 139);
  static Color element_Light = Color.fromARGB(255, 255, 241, 153);
  static Color element_Dark = Color.fromARGB(255, 190, 159, 233);
  static Color element_None = Color.fromARGB(255, 202, 202, 202);
  static Color dark = Color.fromARGB(255, 35, 35, 35);
  static Color darker = Color.fromARGB(255, 27, 27, 27);
  static Color light_grey = Color.fromARGB(255, 180, 180, 180);

  Color getDark() {
    return dark;
  }

  Color getDarker() {
    return darker;
  }

  Color getLightGrey() {
    return light_grey;
  }

  Color getColor(String type) {
    if (type == 'Fire') {
      return AppColors.element_Fire;
    } else if (type == 'Ice') {
      return AppColors.element_Ice;
    } else if (type == 'Earth') {
      return AppColors.element_Earth;
    } else if (type == 'Light') {
      return AppColors.element_Light;
    } else if (type == 'Dark') {
      return AppColors.element_Dark;
    } else {
      return AppColors.element_None;
    }
  }
}
