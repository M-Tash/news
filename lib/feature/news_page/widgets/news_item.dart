import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../model/NewsResponse.dart';

class NewsItem extends StatelessWidget {
  final News news;
  final Function? onItemClick;

  const NewsItem({super.key, required this.news, this.onItemClick});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: () {
              onItemClick!(news);
            },
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.circular(20),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: CachedNetworkImage(
                  imageUrl: news.urlToImage ?? '',
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.3,
                  fit: BoxFit.fill,
                  placeholder: (context, url) => Container(
                    padding: const EdgeInsets.only(
                      left: 150,
                      right: 150,
                      top: 80,
                      bottom: 80,
                    ),
                    child: const CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(news.author ?? '',
              style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 8),
          Text(news.title ?? '', style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: 8),
          Text(
            '${DateFormat.H().format(DateTime.parse(news.publishedAt ?? ''))} hours ago',
            style: Theme.of(context).textTheme.titleSmall,
            textAlign: TextAlign.end,
          )
        ],
      ),
    );
  }
}
