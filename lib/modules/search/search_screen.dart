import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';

class SearchScreen extends StatelessWidget {
  var searchController;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, AppStates>(
      listener: (BuildContext context, AppStates states) {},
      builder: (BuildContext context, AppStates states) {
        var list = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultFormField(
                  controller: searchController,
                  keyboardType: TextInputType.text,
                  onChange: (value) {
                    NewsCubit.get(context).getSearch(value);
                  },
                  validatorFunction: (String value) {
                    if (value.isEmpty)
                      print('Search tab is empty');
                    else
                      return null;
                  },
                  labelText: 'Search',
                  prefixIcon: Icons.search,
                ),
              ),
              Expanded(
                child: buildArticleBuilder(
                  list,
                  context,
                  isSearch: true,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
