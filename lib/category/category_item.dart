import 'package:flutter/material.dart';
import 'package:news_app/category/category.dart';

class CategoryItem extends StatelessWidget {
  CategoryDM category;
  int index;
  CategoryItem({required this.category,required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: category.color,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
          bottomLeft: Radius.circular(
            index.isEven ? 25:0
          ),
          bottomRight: Radius.circular(
            index.isOdd ? 25:0
          ),
        )
      ),
      child: Padding(
        padding:  EdgeInsets.all(8.0),
        child: Column(
          children: [
            Image.asset(category.imagePath,
              height: MediaQuery.of(context).size.height*0.15 ),
            Text(category.title,style: Theme.of(context).textTheme.titleLarge,)
          ],
        ),
      ),
    );
  }
}
