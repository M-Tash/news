import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/theme/my_theme.dart';

import '../model/NewsResponse.dart';

class NewsItem extends StatelessWidget {
  News news;
  Function? onItemClick;

  @override
  NewsItem({required this.news, this.onItemClick});

  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: () {
              onItemClick!(news);
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CachedNetworkImage(
                imageUrl: news.urlToImage ?? '',
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.3,
                fit: BoxFit.fill,
                placeholder: (context, url) => Container(
                  padding: EdgeInsets.only(
                    left: 150,
                    right: 150,
                    top: 80,
                    bottom: 80,
                  ),
                  child: CircularProgressIndicator(
                    backgroundColor: MyTheme.primaryColor,
                  ),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(news.author ?? '',
              style: Theme.of(context).textTheme.titleSmall),
          SizedBox(height: 8),
          Text(news.title ?? '', style: Theme.of(context).textTheme.bodyLarge),
          SizedBox(height: 8),
          Text(
            '${DateFormat.H().format(DateTime.parse(news.publishedAt ?? ''))} hours ago',
            style: Theme.of(context).textTheme.titleSmall,
          textAlign: TextAlign.end,)
        ],
      ),
    );
  }
}
