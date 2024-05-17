import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:news_app/category/category.dart';
import 'package:news_app/category/cubit/category_details_view_model.dart';
import 'package:news_app/category/cubit/states.dart';
import 'package:news_app/di.dart';
import 'package:news_app/tab/tab_widget.dart';
import 'package:news_app/theme/my_theme.dart';

class CategoryDetails extends StatefulWidget {
  static const String routeName = 'category_details';
  CategoryDM category;

  CategoryDetails({required this.category});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  CategoryDetailsViewModel viewModel = CategoryDetailsViewModel(
      repositoryContract: injectSourceRepositoryContract());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.getSources(widget.category.id);
  }

  Widget build(BuildContext context) {
    return BlocBuilder<CategoryDetailsViewModel, SourceStates>(
        bloc: viewModel,
        builder: (context, state) {
          if (state is SourceSuccessState) {
            return TabWidget(sourceList: state.sourcesList);
          } else if (state is SourceErrorState) {
            return Column(
              children: [
                Text(state.errorMessage!),
                ElevatedButton(
                    onPressed: () {},
                    child: Text(AppLocalizations.of(context)!.try_again))
              ],
            );
          } else if (state is SourceLoadingState) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: MyTheme.primaryColor,
              ),
            );
          } else {
            return Container();
          }
        });

    //   Stack(children: [
    //   Container(
    //     color: MyTheme.whiteColor,
    //     child: Image.asset('assets/images/pattern.png',
    //     width: double.infinity,
    //     height: double.infinity,
    //     fit: BoxFit.cover,),
    //   ),
    //   Scaffold(
    //     backgroundColor: Colors.transparent,
    //     body: FutureBuilder<SourceResponse?>(
    //         future: ApiManager.getSources(widget.category.id),
    //         builder: (context,snapshot){
    //           if(snapshot.connectionState == ConnectionState.waiting){
    //             return Center(
    //               child: CircularProgressIndicator(
    //                 backgroundColor: MyTheme.primaryColor,
    //               ),
    //             );
    //           }
    //           else if (snapshot.hasError){
    //             return Column(
    //               children: [
    //                   Text(AppLocalizations.of(context)!.error_message),
    //                   ElevatedButton(
    //                       onPressed: () {
    //                         ApiManager.getSources(widget.category.id);
    //                         setState(() {});
    //                       },
    //                       child: Text(AppLocalizations.of(context)!.try_again))
    //                 ],
    //             );
    //           }
    //           else if (snapshot.data?.status !='ok'){
    //             return Column(
    //               children: [
    //                 Text(snapshot.data!.message!),
    //                 ElevatedButton(
    //                       onPressed: () {
    //                         ApiManager.getSources(widget.category.id);
    //                         setState(() {});
    //                       },
    //                       child: Text(AppLocalizations.of(context)!.try_again))
    //                 ],
    //             );
    //           }
    //           var sourceList =snapshot.data?.sources ?? [];
    //           return TabWidget(sourceList: sourceList);
    //
    //         }
    //
    //     ),
    //   ),
    // ],);
  }
}