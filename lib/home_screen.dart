import 'package:flutter/material.dart';
import 'package:news_app/category/category.dart';
import 'package:news_app/category/category_details.dart';
import 'package:news_app/category/category_fragment.dart';
import 'package:news_app/settings/settings_tab.dart';
import 'package:news_app/theme/my_theme.dart';

import 'drawer/home_drawer.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName ='home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: MyTheme.whiteColor,
          child: Image.asset('assets/images/pattern.png',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text(
              selectedMenuItem==HomeDrawer.settings?
               'Settings':
                  selectedCategory==null?
              'News App':
              selectedCategory!.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          drawer: Drawer(
            child: HomeDrawer(onSideMenuItemClick: onSideMenuItemClick),
          ),
          body: selectedMenuItem==HomeDrawer.settings?
              SettingsTab():
          selectedCategory ==null ?
          CategoryFragment(onCategoryItemClick: onCategoryItemClick):
          CategoryDetails(category: selectedCategory!),

        ),

      ],
    );
  }

  CategoryDM? selectedCategory;

  void onCategoryItemClick(CategoryDM newSelectedCategory){
    selectedCategory =newSelectedCategory;
    setState(() {

    });
  }
  int selectedMenuItem=HomeDrawer.categories;
  void onSideMenuItemClick(int newSelectedMenuItem){
    selectedMenuItem=newSelectedMenuItem;
    selectedCategory=null;
    Navigator.pop(context);
    setState(() {

    });
  }
}
