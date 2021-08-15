import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/business/business_screen.dart';
import 'package:news_app/modules/science/science_screen.dart';
import 'package:news_app/modules/sports/sports_screen.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/shared/network/local/cahce_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<AppStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);
  int screenIndex = 0;
  bool isDark = false;

  //ThemeMode.light

  List<Widget> bodyScreens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];

  void changeBodyScreenIndex(int index) {
    screenIndex = index;
    if (index == 1)
      getSports();
    else if (index == 2) getScience();
    emit(NewsBottomNavState());
  }

  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.sports_soccer_outlined),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: 'Science',
    ),
  ];

  List<dynamic> business = [];

  void getBusiness() {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'business',
        'apiKey': '9390dfe654dd4847866c9e81d8efe660',
      },
    ).then((value) {
      //print(value.data['articles'][0]['title']);
      business = value.data['articles'];
      emit(NewsGetBusinessSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetBusinessFailureState(error.toString()));
    });
  }

  List<dynamic> science = [];

  void getScience() {
    if (science.length == 0) {
      emit(NewsGetScienceLoadingState());
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'science',
          'apiKey': '9390dfe654dd4847866c9e81d8efe660',
        },
      ).then((value) {
        //print(value.data['articles'][0]['title']);
        science = value.data['articles'];
        emit(NewsGetScienceSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetScienceFailureState(error.toString()));
      });
      emit(NewsGetScienceSuccessState());
    }
  }

  List<dynamic> sport = [];

  void getSports() {
    if (sport.length == 0) {
      emit(NewsGetSportsLoadingState());
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'sports',
          'apiKey': '9390dfe654dd4847866c9e81d8efe660',
        },
      ).then((value) {
        sport = value.data['articles'];
        emit(NewsGetSportsSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetSportsFailureState(error.toString()));
      });
    } else {
      emit(NewsGetSportsSuccessState());
    }
  }

  List<dynamic> search = [];

  void getSearch(String value) {
    search = [];
    if (search.length == 0) {
      emit(NewsGetSportsLoadingState());
      DioHelper.getData(
        url: 'v2/everything',
        query: {
          'q': '$value',
          'apiKey': '9390dfe654dd4847866c9e81d8efe660',
        },
      ).then((value) {
        search = value.data['articles'];
        emit(NewsGetSearchSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetSearchFailureState(error.toString()));
      });
    } else {
      emit(NewsGetSearchSuccessState());
    }
  }

  void changeThemeMode({bool sharedDark}) {
    if (sharedDark != null) {
      isDark = sharedDark;
      emit(NewsChangeThemeModeState());
    } else {
      isDark = !isDark;
      CacheHelper.putBoolean(
        key: 'isDark',
        value: isDark,
      ).then((value) {
        emit(NewsChangeThemeModeState());
      });
    }
  }
}
