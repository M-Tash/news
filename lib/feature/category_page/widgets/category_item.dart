import 'package:flutter/material.dart';

import 'category.dart';

class CategoryItem extends StatelessWidget {
  final CategoryDM category;
  final int index;

  const CategoryItem({super.key, required this.category, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: category.color,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(25),
            topRight: const Radius.circular(25),
            bottomLeft: Radius.circular(index.isEven ? 25 : 0),
            bottomRight: Radius.circular(index.isOdd ? 25 : 0),
          )),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Image.asset(category.imagePath,
                height: MediaQuery.of(context).size.height * 0.135),
            Text(
              category.title,
              style: Theme.of(context).textTheme.titleLarge,
            )
          ],
        ),
      ),
    );
  }
}
