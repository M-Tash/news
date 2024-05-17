import 'package:hive/hive.dart';
import 'package:news_app/model/NewsResponse.dart';
import 'package:news_app/repository/news/news_repository_contract.dart';

class NewsOfflineDataSourceImpl implements NewsOfflineDataSource {
  @override
  Future<NewsResponse?> getNews(String sourceId, int page) async {
    var box = await Hive.openBox('news');
    var response = NewsResponse.fromJson(box.get(sourceId));
    return response;
  }

  @override
  void saveNews(newsResponse, String sourceId, int page) async {
    var box = await Hive.openBox('news');
    await box.put(sourceId, newsResponse?.toJson());
    box.close();
  }
}
