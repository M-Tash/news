import 'package:news_app/api/api_manager.dart';
import 'package:news_app/repository/news/dataSource/news_offline_data_source_impl.dart';
import 'package:news_app/repository/news/dataSource/news_remote_data_source_impl.dart';
import 'package:news_app/repository/news/news_repository_contract.dart';
import 'package:news_app/repository/news/repository/news_repository_impl.dart';
import 'package:news_app/repository/sources/dataSource/source_offline_data_source_impl.dart';
import 'package:news_app/repository/sources/dataSource/source_remote_data_source_impl.dart';
import 'package:news_app/repository/sources/repository/source_repository_impl.dart';
import 'package:news_app/repository/sources/source_repository_contract.dart';

SourceRepositoryContract injectSourceRepositoryContract() {
  return SourceRepositoryImpl(
      remoteDataSource: injectSourceRemoteDataSource(),
      offlineDataSource: injectSourceOfflineDataSource());
}

SourceRemoteDataSource injectSourceRemoteDataSource() {
  return SourceRemoteDataSourceImpl(apiManager: ApiManager.getInstance());
}

SourceOfflineDataSource injectSourceOfflineDataSource() {
  return SourceOfflineDataSourceImpl();
}

NewsRepositoryContract injectNewsRepositoryContract() {
  return NewsRepositoryImpl(
      remoteDataSource: injectNewsRemoteDataSource(),
      offlineDataSource: injectNewsOfflineDataSource());
}

NewsRemoteDataSource injectNewsRemoteDataSource() {
  return NewsRemoteDataSourceImpl(apiManager: ApiManager.getInstance());
}

NewsOfflineDataSource injectNewsOfflineDataSource() {
  return NewsOfflineDataSourceImpl();
}
