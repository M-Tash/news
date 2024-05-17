import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:news_app/model/SourceResponse.dart';

import '../source_repository_contract.dart';

class SourceRepositoryImpl implements SourceRepositoryContract {
  SourceRemoteDataSource remoteDataSource;
  SourceOfflineDataSource offlineDataSource;

  SourceRepositoryImpl(
      {required this.remoteDataSource, required this.offlineDataSource});

  @override
  Future<SourceResponse?> getSources(String categoryId) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi)) {
      var sourceResponse = await remoteDataSource.getSources(categoryId);
      offlineDataSource.saveSources(sourceResponse, categoryId);
      return sourceResponse;
    } else {
      var response = await offlineDataSource.getSources(categoryId);
      return response;
    }
  }
}
