import 'package:news_app/core/api_helper/api_manager.dart';
import 'package:news_app/model/NewsResponse.dart';
import 'package:news_app/repository/news/news_repository_contract.dart';

class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  ApiManager apiManager;

  NewsRemoteDataSourceImpl({required this.apiManager});

  @override
  Future<NewsResponse?> getNews(String sourceId, int page) async {
    var response =
        await apiManager.getNewsBySourceId(sourceId: sourceId, page: page);
    return response;
  }
}
