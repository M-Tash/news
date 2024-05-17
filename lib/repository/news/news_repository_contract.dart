import 'package:news_app/model/NewsResponse.dart';

abstract class NewsRepositoryContract {
  Future<NewsResponse?> getNews(String sourceId, int page);
}

abstract class NewsRemoteDataSource {
  Future<NewsResponse?> getNews(String sourceId, int page);
}

abstract class NewsOfflineDataSource {
  Future<NewsResponse?> getNews(String sourceId, int page);

  void saveNews(NewsResponse? newsResponse, String sourceId, int page);
}
