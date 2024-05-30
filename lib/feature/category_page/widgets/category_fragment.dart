import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'category.dart';
import 'category_item.dart';

class CategoryFragment extends StatelessWidget {
  final Function onCategoryItemClick;

  const CategoryFragment({super.key, required this.onCategoryItemClick});

  @override
  Widget build(BuildContext context) {
    List<String> titles = [
      AppLocalizations.of(context)!.sport,
      AppLocalizations.of(context)!.general,
      AppLocalizations.of(context)!.health,
      AppLocalizations.of(context)!.business,
      AppLocalizations.of(context)!.technology,
      AppLocalizations.of(context)!.science,
    ];
    var categoriesList = CategoryDM.getCategories(titles);

    return Container(
      padding: const EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            AppLocalizations.of(context)!.categories_hint,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(
            height: 15,
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
