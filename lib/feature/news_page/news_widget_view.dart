import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:news_app/core/api_helper/api_manager.dart';
import 'package:news_app/feature/news_page/widgets/news_item.dart';
import 'package:news_app/model/SourceResponse.dart';
import 'package:news_app/repository/di.dart';

import '../../config/theme/my_theme.dart';
import '../../model/NewsResponse.dart';
import 'news_view_model/news_details_cubit.dart';
import 'news_view_model/states.dart';
import 'widgets/details_screen.dart';

class NewsWidget extends StatefulWidget {
  final Source source;

  const NewsWidget({super.key, required this.source});

  Future<NewsResponse?> searchNews(String searchQuery) async {
    try {
      return await ApiManager.searchNews(query: searchQuery);
    } catch (e) {
      rethrow;
    }
  }

  @override
  State<NewsWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  NewsDetailsCubit cubit =
      NewsDetailsCubit(repositoryContract: injectNewsRepositoryContract());
  late ScrollController scrollController;
  int currentPage = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cubit.getNews(widget.source.id!, currentPage);
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
          child: BlocBuilder<NewsDetailsCubit, NewsStates>(
            bloc: cubit,
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
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is NewsErrorState) {
                return Column(
                  children: [
                    Text(state.errorMessage!),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          foregroundColor: MyTheme.primaryColor),
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
