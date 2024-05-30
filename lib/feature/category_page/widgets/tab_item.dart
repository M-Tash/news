import 'package:flutter/material.dart';
import 'package:news_app/config/theme/my_theme.dart';

import '../../../model/SourceResponse.dart';

class TabItem extends StatelessWidget {
  final bool isSelected;

  final Source source;

  const TabItem({super.key, required this.source, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
      decoration: BoxDecoration(
          border: Border.all(color: MyTheme.primaryColor, width: 2),
          borderRadius: BorderRadius.circular(15),
          color: isSelected ? MyTheme.primaryColor : Colors.transparent),
      child: Text(
        source.name ?? '',
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: isSelected ? MyTheme.whiteColor :MyTheme.primaryColor,
            fontSize: 18
        ),
      ),
    );
  }
}
