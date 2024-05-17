import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:news_app/api/api_manager.dart';
import 'package:news_app/di.dart';
import 'package:news_app/model/SourceResponse.dart';
import 'package:news_app/news/news_item.dart';

import '../model/NewsResponse.dart';
import '../theme/my_theme.dart';
import 'cubit/news_details_view_model.dart';
import 'cubit/states.dart';
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
  NewsDetailsViewModel viewModel =
      NewsDetailsViewModel(repositoryContract: injectNewsRepositoryContract());
  late ScrollController scrollController;
  int currentPage = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.getNews(widget.source.id!, currentPage);
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
          child: BlocBuilder(
            bloc: viewModel,
            builder: (context, state) {
              if (state is NewsSuccessState) {
                final newsList = state.newsList;
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
              } else if (state is NewsLoadingState) {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: MyTheme.primaryColor,
                  ),
                );
              } else if (state is NewsErrorState) {
                return Column(
                  children: [
                    Text(state.errorMessage!),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {});
                      },
                      child: Text(AppLocalizations.of(context)!.try_again),
                    ),
                  ],
                );
              }
              return Text(AppLocalizations.of(context)!.try_again);
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
