import 'package:flutter/material.dart';
import 'package:news_app/api/api_manager.dart';
import 'package:news_app/model/NewsResponse.dart';
import 'package:news_app/model/SourceResponse.dart';
import 'package:news_app/news/news_item.dart';
import 'package:url_launcher/url_launcher.dart';


import '../theme/my_theme.dart';

class NewsWidget extends StatefulWidget {
  Source source;
  NewsWidget({required this.source});

  @override
  State<NewsWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  @override
  Widget build(BuildContext context) {
    return  FutureBuilder<NewsResponse?>(
        future: ApiManager.getNewsBySourceId(widget.source.id??''),
        builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: MyTheme.primaryColor,
              ),
            );
          }
          else if (snapshot.hasError){
            return Column(
              children: [
                Text('something went Wrong '),
                ElevatedButton(onPressed: (){
                  ApiManager.getNewsBySourceId(widget.source.id??'');
                  setState(() {

                  });
                }, child: Text('Try Again'))
              ],
            );
          }
          else if (snapshot.data?.status !='ok'){
            return Column(
              children: [
                Text(snapshot.data!.message!),
                ElevatedButton(onPressed: (){
                  ApiManager.getNewsBySourceId(widget.source.id??'');
                  setState(() {

                  });
                }, child: Text('Try Again'))
              ],
            );
          }
          var newsList =snapshot.data?.articles ?? [];
          return ListView.builder(itemBuilder: (context,index){
            return NewsItem(news: newsList[index]);
          },
            itemCount: newsList.length,
          );


        });
  }
}
