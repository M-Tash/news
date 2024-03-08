import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/api/api_constants.dart';
import 'package:news_app/model/NewsResponse.dart';
import 'package:news_app/model/SourceResponse.dart';
class ApiManager{

  static Future<SourceResponse?> getSources(String categoryId)async{
    Uri url =Uri.https(ApiConstants.baseUrl,ApiConstants.sourcesApi,
    {
      'apiKey' : '1acb2b24c19c406190c114d2052e8cca',
      'category':categoryId,
    });
    try{
      var response = await http.get(url);
      var responseBody =response.body ;
      var json = jsonDecode(responseBody);
     return SourceResponse.fromJson(json);
    }catch(e){
      throw e ;

    }

  }

  static Future<NewsResponse?> getNewsBySourceId(String sourceId)async{
    Uri url =Uri.https(ApiConstants.baseUrl,
    ApiConstants.newsApi,
    {
      'apiKey' : '1acb2b24c19c406190c114d2052e8cca',
      'sources': sourceId
    });
    try{
      var response = await http.get(url);
      var responseBody =response.body ;
      var json = jsonDecode(responseBody);
      return NewsResponse.fromJson(json);
    }catch(e){
      throw e ;
    }


  }

}