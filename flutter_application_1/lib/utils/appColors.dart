// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

//Colors used in the app
class AppColors {
  //Elements
  static Color element_Fire = const Color.fromARGB(255, 255, 135, 135);
  static Color element_Ice = const Color.fromARGB(255, 126, 206, 246);
  static Color element_Earth = const Color.fromARGB(255, 121, 239, 139);
  static Color element_Light = const Color.fromARGB(255, 255, 241, 153);
  static Color element_Dark = const Color.fromARGB(255, 190, 159, 233);
  static Color element_None = const Color.fromARGB(255, 202, 202, 202);
  //Widgets
  static Color dark = const Color.fromARGB(255, 35, 35, 35);
  static Color darker = const Color.fromARGB(255, 27, 27, 27);
  static Color much_darker = const Color.fromARGB(255, 14, 14, 14);
  static Color light_grey = const Color.fromARGB(255, 180, 180, 180);

  //Returns the color corresponding to the element string
  static Color getColor(String type) {
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
