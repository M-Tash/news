import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:news_app/category/category.dart';
import 'package:news_app/category/category_details.dart';
import 'package:news_app/category/category_fragment.dart';
import 'package:news_app/news/search_widget.dart';
import 'package:news_app/settings/settings_tab.dart';
import 'package:news_app/theme/my_theme.dart';

import 'drawer/home_drawer.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController textController = TextEditingController();

  bool search = false;
  bool searchBar = false;
  String? searchQuery;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: MyTheme.whiteColor,
          child: Image.asset(
            'assets/images/pattern.png',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: searchBar
              ? AppBar(
                  title: Container(
                  height: 50,
                  margin: EdgeInsets.only(
                    bottom: 0,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: MyTheme.whiteColor),
                  child: TextField(
                    cursorColor: MyTheme.primaryColor,
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                        if (searchQuery == null || searchQuery!.isEmpty) {
                          return;
                        }
                        search = true;
                      });
                    },
                    decoration: InputDecoration(
                        hintStyle: TextStyle(
                            color: MyTheme.primaryColor, fontSize: 15),
                        border: InputBorder.none,
                        hintText: AppLocalizations.of(context)!.search,
                        prefixIcon: IconButton(
                            icon: Icon(
                              Icons.close,
                              size: 30,
                              color: MyTheme.primaryColor,
                            ),
                            onPressed: () {
                              search = false;
                              searchBar = false;
                              setState(() {});
                            }),
                        suffixIcon: IconButton(
                            onPressed: () {
                              search = true;
                              SystemChannels.textInput
                                  .invokeMethod('TextInput.hide');
                              setState(() {});
                            },
                            icon: Icon(
                              Icons.search,
                              size: 30,
                              color: MyTheme.primaryColor,
                            ))),
                  ),
                ))
              : AppBar(
                  title: Text(
              selectedMenuItem == HomeDrawer.settings
                        ? AppLocalizations.of(context)!.settings
                        : selectedCategory == null
                            ? AppLocalizations.of(context)!.app_title
                            : selectedCategory!.title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  actions: [
                    IconButton(
                        onPressed: () {
                          searchBar = !searchBar;
                          setState(() {});
                        },
                        icon: Padding(
                          padding: EdgeInsets.only(right: 11),
                          child: Icon(
                            Icons.search,
                            size: 30,
                          ),
                        ))
                  ],
                ),
          drawer: searchBar
              ? null
              : Drawer(
                  child: HomeDrawer(onSideMenuItemClick: onSideMenuItemClick),
                ),
          body: search
              ? SearchWidget(searchQuery: searchQuery)
              : selectedMenuItem == HomeDrawer.settings
                  ? SettingsTab()
                  : selectedCategory == null
                      ? CategoryFragment(
                          onCategoryItemClick: onCategoryItemClick)
                      : CategoryDetails(category: selectedCategory!),
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
