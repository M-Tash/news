
import 'package:flutter/material.dart';
import 'package:news_app/home_screen.dart';
import 'package:news_app/news/details_screen.dart';
import 'package:news_app/theme/my_theme.dart';


void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        DetailsScreen.routeName: (context) => DetailsScreen(),
      },
      theme: MyTheme.lightMode,
    );


  }
}