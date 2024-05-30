import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/feature/news_page/news_view_model/states.dart';
import 'package:news_app/repository/news/news_repository_contract.dart';

class NewsDetailsCubit extends Cubit<NewsStates> {
  NewsRepositoryContract repositoryContract;

  NewsDetailsCubit({required this.repositoryContract})
      : super(NewsLoadingState());

  void getNews(String sourceId, int page) async {
    try {
      emit(NewsLoadingState());
      var response = await repositoryContract.getNews(sourceId, page);
      if (response!.status == 'error') {
        emit(NewsErrorState(errorMessage: response.message));
        return;
      }
      if (response.status == 'ok') {
        emit(NewsSuccessState(newsList: response.articles!));
        return;
      }
    } catch (e) {
      emit(NewsErrorState(errorMessage: 'Error Loading'));
    }
  }
}
