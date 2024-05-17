import 'package:news_app/model/SourceResponse.dart';

abstract class SourceRepositoryContract {
  Future<SourceResponse?> getSources(String categoryId);
}

abstract class SourceRemoteDataSource {
  Future<SourceResponse?> getSources(String categoryId);
}

abstract class SourceOfflineDataSource {
  Future<SourceResponse?> getSources(String categoryId);

  void saveSources(SourceResponse? sourceResponse, String category);
}
