import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/api/api_constants.dart';
import 'package:news_app/model/NewsResponse.dart';
import 'package:news_app/model/SourceResponse.dart';
class ApiManager{

  static Future<SourceResponse?> getSources(String categoryId)async{
    Uri url =Uri.https(ApiConstants.baseUrl,ApiConstants.sourcesApi,
    {
      'apiKey': '8398ab1f2cd84107a6b66ea205766f07',
      'category': categoryId,
    });
    try{
      var response = await http.get(url);
      var responseBody =response.body ;
      var json = jsonDecode(responseBody);
     return SourceResponse.fromJson(json);
    }catch(e){
      throw e;
    }
  }

  static Future<NewsResponse?> getNewsBySourceId(
      {required String sourceId, int page = 1}) async {
    Uri url = Uri.https(ApiConstants.baseUrl, ApiConstants.newsApi, {
      'apiKey': '8398ab1f2cd84107a6b66ea205766f07',
      'sources': sourceId,
      'page': page.toString(),
    });
    try {
      var response = await http.get(url);
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      return NewsResponse.fromJson(json);
    } catch (e) {
      throw e;
    }
  }

  static Future<NewsResponse?> searchNews({required String query}) async {
    Uri url = Uri.https(ApiConstants.baseUrl, ApiConstants.newsApi, {
      'apiKey': '8398ab1f2cd84107a6b66ea205766f07',
      'q': query,
    });
    try {
      var response = await http.get(url);
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      return NewsResponse.fromJson(json);
    } catch (e) {
      throw e;
    }
  }

}