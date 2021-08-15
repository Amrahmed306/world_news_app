import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';

class SportsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsCubit.get(context).sport;
        return buildArticleBuilder(list,context);
      },
    );
  }
}
