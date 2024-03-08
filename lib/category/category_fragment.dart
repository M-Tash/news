import 'package:flutter/material.dart';
import 'package:news_app/category/category.dart';
import 'package:news_app/category/category_item.dart';

class CategoryFragment extends StatelessWidget {
var categoriesList = CategoryDM.getCategories();
 Function onCategoryItemClick;
 CategoryFragment({required this.onCategoryItemClick});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(25),
      child: Column( crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Pick your category \n of interest'
            ,style: Theme.of(context).textTheme.titleMedium ,),
          SizedBox(height: 15,),
          Expanded(
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 20,
                ),
                itemBuilder: (context,index){
                  return InkWell(onTap: (){
                    onCategoryItemClick(categoriesList[index]);
                  },
                      child: CategoryItem(category: categoriesList[index], index: index));
                },
                itemCount: categoriesList.length,),
          )
        ],
      ),
    );
}
}
