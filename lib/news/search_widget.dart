import 'package:flutter/material.dart';
import 'package:news_app/api/api_manager.dart';
import 'package:news_app/model/NewsResponse.dart';
import 'package:news_app/news/news_item.dart';

import '../theme/my_theme.dart';
import 'details_screen.dart';

class SearchWidget extends StatefulWidget {
  String? searchQuery;

  SearchWidget({required this.searchQuery});

  Future<NewsResponse?> searchNews(String searchQuery) async {
    try {
      return await ApiManager.searchNews(query: searchQuery);
    } catch (e) {
      throw e;
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
                    Text('Something went wrong '),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {});
                      },
                      child: Text('Try again'),
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
                      child: Text('Try again'),
                    ),
                  ],
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
