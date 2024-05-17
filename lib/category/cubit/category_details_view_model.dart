import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/category/cubit/states.dart';

import '../../repository/sources/source_repository_contract.dart';

class CategoryDetailsViewModel extends Cubit<SourceStates> {
  SourceRepositoryContract repositoryContract;

  CategoryDetailsViewModel({required this.repositoryContract})
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
