import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/search/search_screen.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';

class NewsLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, AppStates>(
      listener: (BuildContext context, AppStates states) {},
      builder: (BuildContext context, AppStates states) {
        NewsCubit cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'News App',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.search,
                ),
                onPressed: () {
                  navigateTo(
                    context,
                    SearchScreen(),
                  );
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.brightness_4_outlined,
                ),
                onPressed: () {
                  cubit.changeThemeMode();
                },
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.screenIndex,
            onTap: (index) {
              cubit.changeBodyScreenIndex(index);
            },
            items: cubit.bottomItems,
          ),
          body: cubit.bodyScreens[cubit.screenIndex],
        );
      },
    );
  }
}
