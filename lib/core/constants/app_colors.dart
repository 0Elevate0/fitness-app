import 'package:flutter/material.dart';

abstract final class AppColors {
  static const Color white = Color(0xffFFFFFF);
  static const Color green = Colors.green;

  static const MaterialColor gray = MaterialColor(0xffD3D3D3, <int, Color>{
    10: Color(0xffD9D9D9),
    20: Color(0xffD3D3D3),
    30: Color(0xffBDBDBD),
    40: Color(0xffA7A7A7),
    50: Color(0xff919191),
    0: Color(0xffD3D3D3),
    60: Color(0xff7C7C7C),
    70: Color(0xff666666),
    80: Color(0xff505050),
    90: Color(0xff3A3A3A),
    100: Color(0xff242424),
  });

  static const MaterialColor black = MaterialColor(0xff242424, <int, Color>{
    10: Color(0xff000000),
    20: Color(0xff1A1A1A),
    30: Color(0xff000000),
    40: Color(0xff000000),
    50: Color(0xff000000),
    0: Color(0xff242424),
    60: Color(0xff000000),
    70: Color(0xff000000),
    80: Color(0xff000000),
    90: Color(0xff0B0B0B),
    100: Color(0xff242424),
  });
  static const MaterialColor lightOrange =
      MaterialColor(0xffFF6A00, <int, Color>{
        10: Color(0xffFFECE5),
        20: Color(0xffFFD9CC),
        30: Color(0xffFFC6B2),
        40: Color(0xffFFB399),
        50: Color(0xffFFA080),
        0: Color(0xffFF6A00),
        60: Color(0xffFF8D66),
        70: Color(0xffFF7A4D),
        80: Color(0xffFF6A00),
        90: Color(0xffFF541A),
        100: Color(0xffFF4100),
      });
  static const MaterialColor orange = MaterialColor(0xffFF4100, <int, Color>{
    10: Color(0xff1A0000),
    20: Color(0xff330000),
    30: Color(0xff4D0000),
    40: Color(0xff660000),
    50: Color(0xff800000),
    0: Color(0xffFF4100),
    60: Color(0xff990000),
    70: Color(0xffB20000),
    80: Color(0xffCC0E00),
    90: Color(0xffE52800),
    100: Color(0xffFF4100),
  });
}
