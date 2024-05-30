import 'package:flutter/material.dart';

class MyTheme {
  static Color primaryColor = const Color(0xff39A552);
  static Color whiteColor = const Color(0xffFFFFFF);
  static Color blackColor = const Color(0xff303030);
  static Color greyColor = const Color(0xff4F5A69);
  static Color redColor = const Color(0xffC91C22);
  static Color darkBlueColor = const Color(0xff003E90);
  static Color pinkColor = const Color(0xffED1E79);
  static Color brownColor = const Color(0xffCF7E48);
  static Color blueColor = const Color(0xff4882CF);
  static Color yellowColor = const Color(0xffF2D352);
  static ThemeData lightMode = ThemeData(
    appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: whiteColor),
        backgroundColor: primaryColor,
        centerTitle: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30)))),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        color: whiteColor,
        fontSize: 22,
        fontWeight: FontWeight.bold
      ),
      titleMedium: TextStyle(
        color: greyColor,
        fontSize: 20,
        fontWeight: FontWeight.w800
      ),
      titleSmall: TextStyle(
        color: greyColor,
        fontSize: 13,
        fontWeight: FontWeight.w400
      ),
      bodyLarge: TextStyle(
        color: blackColor,
        fontSize: 14,
        fontWeight: FontWeight.bold
      ),
      bodyMedium: TextStyle(
        color: primaryColor,
        fontSize: 14,
        fontWeight: FontWeight.w600
      ),

    ),
  );
}