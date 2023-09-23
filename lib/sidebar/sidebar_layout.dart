import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholarsync/sidebar/sidebar.dart';
import 'bloc.navigation_bloc/navigation_bloc.dart';

//also this page dont need any changes..
//note: when we need show our side bar, we need to call this widget... O.K.
class SidebarLayout extends StatelessWidget {
  const SidebarLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider <NavigationBloc>(
            create: (context) => NavigationBloc(),
            child:  Stack(
              children:  [
                BlocBuilder<NavigationBloc, NavigationStates>(
                  builder: (context, navigationState) {
                return navigationState as Widget;
              },
                ),
                const SideBar(),
              ],
            ),
          ),
    );
  }
}