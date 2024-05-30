import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:news_app/config/theme/my_theme.dart';
import 'package:news_app/feature/category_page/category_view_model/category_details_cubit.dart';
import 'package:news_app/feature/category_page/category_view_model/states.dart';
import 'package:news_app/feature/category_page/widgets/category.dart';
import 'package:news_app/feature/category_page/widgets/tab_widget.dart';
import 'package:news_app/repository/di.dart';

class CategoryDetails extends StatefulWidget {
  static const String routeName = 'category_details';
  final CategoryDM category;

  const CategoryDetails({super.key, required this.category});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  CategoryDetailsCubit cubit = CategoryDetailsCubit(
      repositoryContract: injectSourceRepositoryContract());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cubit.getSources(widget.category.id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryDetailsCubit, SourceStates>(
        bloc: cubit,
        builder: (context, state) {
          if (state is SourceSuccessState) {
            return TabWidget(sourceList: state.sourcesList);
          } else if (state is SourceErrorState) {
            return Column(
              children: [
                Text(state.errorMessage!),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        foregroundColor: MyTheme.primaryColor),
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
            return Text(AppLocalizations.of(context)!.try_again);
          }
        });
  }
}