import 'package:flutter/material.dart';

class MyTheme {
  static Color primaryColor = Color(0xff39A552);
  static Color whiteColor = Color(0xffFFFFFF);
  static Color blackColor = Color(0xff303030);
  static Color greyColor = Color(0xff4F5A69);
  static Color redColor = Color(0xffC91C22);
  static Color darkBlueColor = Color(0xff003E90);
  static Color pinkColor = Color(0xffED1E79);
  static Color brownColor = Color(0xffCF7E48);
  static Color blueColor = Color(0xff4882CF);
  static Color yellowColor = Color(0xffF2D352);
  static ThemeData lightMode = ThemeData(
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(
        color: whiteColor
      ),
      backgroundColor: primaryColor,
      centerTitle: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30)
        )
      )
    ),
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
static ThemeData darkMode = ThemeData();


}