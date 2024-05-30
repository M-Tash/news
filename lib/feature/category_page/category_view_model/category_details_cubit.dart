import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/feature/category_page/category_view_model/states.dart';

import '../../../repository/sources/source_repository_contract.dart';

class CategoryDetailsCubit extends Cubit<SourceStates> {
  SourceRepositoryContract repositoryContract;

  CategoryDetailsCubit({required this.repositoryContract})
      : super(SourceLoadingState());

  void getSources(String categoryId) async {
    try {
      emit(SourceLoadingState());
      var response = await repositoryContract.getSources(categoryId);
      if (response!.status == 'error') {
        emit(SourceErrorState(errorMessage: response.message));
        return;
      }
      if (response.status == 'ok') {
        emit(SourceSuccessState(sourcesList: response.sources!));
        return;
      }
    } catch (e) {
      emit(SourceErrorState(errorMessage: 'Error Loading'));
    }
  }
}
