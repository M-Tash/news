import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:news_app/theme/my_theme.dart';

class HomeDrawer extends StatelessWidget {
  static const int categories =1;
  static const int settings =2;
Function onSideMenuItemClick;
HomeDrawer({required this.onSideMenuItemClick});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color:MyTheme.primaryColor,
          width: double.infinity,
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height*0.07),
          child: Text('News APP !',
            style: Theme.of(context).textTheme.titleLarge,
          textAlign: TextAlign.center,),
        ),
        SizedBox(height: 25,),
        InkWell(
          onTap: (){
            onSideMenuItemClick(categories);
          },
          child: Row(
            children: [
              SizedBox(width: 10),
              Icon(CupertinoIcons.list_bullet,size: 40,),
              SizedBox(width: 15),
              Text('Categories',style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: 23
              ),)
            ],
          ),
        ),
        SizedBox(height: 25,),
        InkWell(
          onTap: (){
            onSideMenuItemClick(settings);
          },
          child: Row(
            children: [
              SizedBox(width: 10),
              Icon(Icons.settings,size: 40,),
              SizedBox(width: 15),
              Text('Settings',style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 23
              ),)
            ],
          ),
        ),

      ],
    );
  }
}
