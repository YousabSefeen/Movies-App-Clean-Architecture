import 'package:flutter/material.dart';

class AppColors {
  static Color customGreenColor = const Color(0xff7cb518);
  static Color customOrangeColor = const Color(0xffED9A00);
  static Color customGreyColor = Colors.grey.shade800;
  static Color customPurpleColor = const Color(0xff63146C);

  static Color scaffoldBackgroundColorLightMode = customPurpleColor;
  static Color scaffoldBackgroundColorDarkMode = const Color(0xff002330);

  static List<Color> colorGradient = const [
    Color(0xff23074d),
    Color(0xffcc5333)
  ];
  static List<Color> lightModeColorGradient = const [
    Color(0xff23074d),
    Color(0xffcc5333)
  ];

  static List<Color> darkModeColorGradient = const [
    Color(0xff000000),
    Color(0xff444444)
  ];
}
