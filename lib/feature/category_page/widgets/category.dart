import 'package:flutter/material.dart';
import 'package:news_app/config/theme/my_theme.dart';

class CategoryDM {
  String id;

  String title;

  String imagePath;

  Color color;

  CategoryDM({
    required this.id,
    required this.title,
    required this.imagePath, required this.color,
  });
  // entertainment
  static List<CategoryDM> getCategories(List<String> title) {
    return [
      CategoryDM(
          id: 'sports',
          title: title[0],
          imagePath: 'assets/images/sports.png',
          color: MyTheme.redColor),
      CategoryDM(
          id: 'general',
          title: title[1],
          imagePath: 'assets/images/general.png',
          color: MyTheme.darkBlueColor),
      CategoryDM(
          id: 'health',
          title: title[2],
          imagePath: 'assets/images/health.png',
          color: MyTheme.pinkColor),
      CategoryDM(
          id: 'business',
          title: title[3],
          imagePath: 'assets/images/business.png',
          color: MyTheme.brownColor),
      CategoryDM(
          id: 'technology',
          title: title[4],
          imagePath: 'assets/images/virtual-reality.png',
          color: MyTheme.blueColor),
      CategoryDM(
          id: 'science',
          title: title[5],
          imagePath: 'assets/images/science.png',
          color: MyTheme.yellowColor),
    ];
  }
}