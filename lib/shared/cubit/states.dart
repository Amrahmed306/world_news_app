abstract class AppStates {}

class NewsInitialState extends AppStates {}

class NewsBottomNavState extends AppStates {}

class NewsGetBusinessSuccessState extends AppStates {}

class NewsGetBusinessFailureState extends AppStates {
  final String error;

  NewsGetBusinessFailureState(this.error);
}

class NewsGetBusinessLoadingState extends AppStates {}

class NewsGetSportsSuccessState extends AppStates {}

class NewsGetSportsFailureState extends AppStates {
  final String error;

  NewsGetSportsFailureState(this.error);
}

class NewsGetSportsLoadingState extends AppStates {}

class NewsGetScienceSuccessState extends AppStates {}

class NewsGetScienceFailureState extends AppStates {
  final String error;

  NewsGetScienceFailureState(this.error);
}

class NewsGetScienceLoadingState extends AppStates {}

class NewsChangeThemeModeState extends AppStates {}

class NewsGetSearchSuccessState extends AppStates {}

class NewsGetSearchFailureState extends AppStates {
  final String error;

  NewsGetSearchFailureState(this.error);
}

class NewsGetSearchLoadingState extends AppStates {}
