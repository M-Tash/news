import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:news_app/api/api_manager.dart';
import 'package:news_app/model/NewsResponse.dart';
import 'package:news_app/model/SourceResponse.dart';
import 'package:news_app/news/news_item.dart';

import '../theme/my_theme.dart';
import 'details_screen.dart';

class NewsWidget extends StatefulWidget {
  Source source;

  NewsWidget({required this.source});

  Future<NewsResponse?> searchNews(String searchQuery) async {
    try {
      return await ApiManager.searchNews(query: searchQuery);
    } catch (e) {
      throw e;
    }
  }

  @override
  State<NewsWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  late ScrollController scrollController;
  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        loadNextPage();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: FutureBuilder<NewsResponse?>(
            future: ApiManager.getNewsBySourceId(
                sourceId: widget.source.id ?? '', page: currentPage),
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
                return Column(
                  children: [
                    Text(snapshot.data!.message!),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {});
                      },
                      child: Text(AppLocalizations.of(context)!.try_again),
                    ),
                  ],
                );
              }
              final newsList = snapshot.data?.articles ?? [];
              return ListView.builder(
                controller: scrollController,
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

  void loadNextPage() {
    setState(() {
      currentPage++;
    });
  }

  void onItemClick(News news) {
    Navigator.pushNamed(context, DetailsScreen.routeName,
        arguments: Arguments(
          news: news,
        ));
  }
}