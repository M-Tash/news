import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:news_app/api/api_manager.dart';
import 'package:news_app/category/category.dart';
import 'package:news_app/model/SourceResponse.dart';
import 'package:news_app/tab/tab_widget.dart';
import 'package:news_app/theme/my_theme.dart';

class CategoryDetails extends StatefulWidget {
  static const String routeName = 'category_details';
  CategoryDM category;

  CategoryDetails({required this.category});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        color: MyTheme.whiteColor,
        child: Image.asset('assets/images/pattern.png',
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,),
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        body: FutureBuilder<SourceResponse?>(
            future: ApiManager.getSources(widget.category.id),
            builder: (context,snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: MyTheme.primaryColor,
                  ),
                );
              }
              else if (snapshot.hasError){
                return Column(
                  children: [
                      Text(AppLocalizations.of(context)!.error_message),
                      ElevatedButton(
                          onPressed: () {
                            ApiManager.getSources(widget.category.id);
                            setState(() {});
                          },
                          child: Text(AppLocalizations.of(context)!.try_again))
                    ],
                );
              }
              else if (snapshot.data?.status !='ok'){
                return Column(
                  children: [
                    Text(snapshot.data!.message!),
                    ElevatedButton(
                          onPressed: () {
                            ApiManager.getSources(widget.category.id);
                            setState(() {});
                          },
                          child: Text(AppLocalizations.of(context)!.try_again))
                    ],
                );
              }
              var sourceList =snapshot.data?.sources ?? [];
              return TabWidget(sourceList: sourceList);

            }

        ),
      ),
    ],

    );

  }
}