import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:news_app/model/NewsResponse.dart';

import '../news_repository_contract.dart';

class NewsRepositoryImpl implements NewsRepositoryContract {
  NewsRemoteDataSource remoteDataSource;
  NewsOfflineDataSource offlineDataSource;

  NewsRepositoryImpl(
      {required this.remoteDataSource, required this.offlineDataSource});

  @override
  Future<NewsResponse?> getNews(String sourceId, int page) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi)) {
      var newsResponse = await remoteDataSource.getNews(sourceId, page);
      offlineDataSource.saveNews(newsResponse, sourceId, page);
      return newsResponse;
    } else {
      var response = await offlineDataSource.getNews(sourceId, page);
      return response;
    }
  }
}
