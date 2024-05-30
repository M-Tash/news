import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:news_app/config/theme/my_theme.dart';

class HomeDrawer extends StatelessWidget {
  static const int categories = 1;
  static const int settings = 2;
  final Function onSideMenuItemClick;

  const HomeDrawer({super.key, required this.onSideMenuItemClick});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: MyTheme.primaryColor,
          width: double.infinity,
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * 0.07),
          child: Text(
            AppLocalizations.of(context)!.app_title,
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        InkWell(
          onTap: () {
            onSideMenuItemClick(categories);
          },
          child: Row(
            children: [
              const SizedBox(width: 10),
              Icon(
                CupertinoIcons.list_bullet,
                size: 40,
              ),
              const SizedBox(width: 15),
              Text(
                AppLocalizations.of(context)!.categories,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontSize: 23),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        InkWell(
          onTap: () {
            onSideMenuItemClick(settings);
          },
          child: Row(
            children: [
              const SizedBox(width: 10),
              const Icon(
                Icons.settings,
                size: 40,
              ),
              const SizedBox(width: 15),
              Text(
                AppLocalizations.of(context)!.settings,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontSize: 23),
              )
            ],
          ),
        ),

      ],
    );
  }
}
