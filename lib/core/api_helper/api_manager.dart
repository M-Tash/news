import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/core/api_helper/keys/keys.dart';
import 'package:news_app/model/SourceResponse.dart';

import '../../model/NewsResponse.dart';

class ApiManager {
  static ApiManager? _instance;

  ApiManager._();

  static ApiManager getInstance() {
    _instance ??= ApiManager._();
    return _instance!;
  }

  Future<SourceResponse?> getSources(String categoryId) async {
    Uri url = Uri.https(ApiConstants.baseUrl, ApiConstants.sourcesApi, {
      'apiKey': ApiKey.key,
      'category': categoryId,
    });
    try {
      var response = await http.get(url);
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      return SourceResponse.fromJson(json);
    }catch(e){
      rethrow;
    }
  }

  Future<NewsResponse?> getNewsBySourceId(
      {required String sourceId, int page = 1}) async {
    Uri url = Uri.https(ApiConstants.baseUrl, ApiConstants.newsApi, {
      'apiKey': ApiKey.key,
      'sources': sourceId,
      'page': page.toString(),
    });
    try {
      var response = await http.get(url);
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      return NewsResponse.fromJson(json);
    } catch (e) {
      rethrow;
    }
  }

  static Future<NewsResponse?> searchNews({required String query}) async {
    Uri url = Uri.https(ApiConstants.baseUrl, ApiConstants.newsApi, {
      'apiKey': ApiKey.key,
      'q': query,
    });
    try {
      var response = await http.get(url);
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      return NewsResponse.fromJson(json);
    } catch (e) {
      rethrow;
    }
  }
}

class ApiConstants {
  static const String baseUrl = 'newsapi.org';
  static const String sourcesApi = '/v2/top-headlines/sources';
  static const String newsApi = '/v2/everything';
}