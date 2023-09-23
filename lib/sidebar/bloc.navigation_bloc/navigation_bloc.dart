// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';

import '../../views/pages/home/home_page.dart';
import '../../views/pages/home/settings_page.dart';


enum NavigationEvents {
  homePageClickedEvent,
  settingsPageClickedEvent,
  //first we need to create NavigationEvent here
  
}

abstract class NavigationStates {}



class NavigationBloc extends Bloc<NavigationEvents, NavigationStates> {
  NavigationBloc() : super(const HomePage()) {
    on<NavigationEvents>((event, emit) {
      switch (event) {
        case NavigationEvents.homePageClickedEvent:
          emit(const HomePage());
          break;
        case NavigationEvents.settingsPageClickedEvent:
          emit(const SettingsPage());
          break;
        //scond we need to call that NavigationEvents here like above
        //note we code emit, 'e' need to be simple
        //we need add other side bar stuff like as above switch case
      }
    });
  }
}
