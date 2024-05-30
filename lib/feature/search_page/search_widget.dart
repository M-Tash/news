import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:news_app/core/api_helper/api_manager.dart';
import 'package:news_app/feature/news_page/widgets/news_item.dart';

import '../../config/theme/my_theme.dart';
import '../../model/NewsResponse.dart';
import '../news_page/widgets/details_screen.dart';

class SearchWidget extends StatefulWidget {
  final String? searchQuery;

  const SearchWidget({super.key, required this.searchQuery});

  Future<NewsResponse?> searchNews(String searchQuery) async {
    try {
      return await ApiManager.searchNews(query: searchQuery);
    } catch (e) {
      rethrow;
    }
  }

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: FutureBuilder<NewsResponse?>(
            future: widget.searchNews(widget.searchQuery!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: MyTheme.primaryColor,
                  ),
                );
              } else if (snapshot.hasError) {
                return Column(
                  children: [
                    Text(AppLocalizations.of(context)!.error_message),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {});
                      },
                      child: Text(AppLocalizations.of(context)!.try_again),
                    ),
                  ],
                );
              } else if (snapshot.data?.status != 'ok') {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        Text(AppLocalizations.of(context)!.result_not_found),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              foregroundColor: MyTheme.primaryColor),
                          onPressed: () {
                            setState(() {});
                          },
                          child: Text(AppLocalizations.of(context)!.try_again),
                        ),
                      ],
                    ),
                  ),
                );
              }
              final newsList = snapshot.data?.articles ?? [];
              return ListView.builder(
                itemBuilder: (context, index) {
                  return NewsItem(
                    news: newsList[index],
                    onItemClick: onItemClick,
                  );
                },
                itemCount: newsList.length,
              );
            },
          ),
        ),
      ],
    );
  }

  void onItemClick(News news) {
    Navigator.pushNamed(context, DetailsScreen.routeName,
        arguments: Arguments(
          news: news,
        ));
  }
}
