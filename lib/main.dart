import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';
import 'package:scholarsync/controllers/firebase_api.dart';
import 'package:scholarsync/themes/app_theme.dart';
import 'package:scholarsync/views/pages/home/home_page.dart';
import 'themes/palette.dart';
import 'utils/tab_navigator.dart';
import 'views/pages/calendar/calendar_page.dart';
import 'views/pages/my_profile/my_profile_page.dart';
import 'views/pages/notifications/notifications_page.dart';
import 'views/widgets/drawer_menu.dart';
import 'views/widgets/nav_add.dart';
import 'views/widgets/nav_item.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'views/pages/auth/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ScholarSync',
        home: AuthWrapper(),
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const MainApp();
          } else {
            return const LogInPage();
          }
        },
      ),
    );
  }
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int currentIndex = 0;
  String currentPage = 'home';

  List<String> pageKeys = [
    'home',
    'calendar',
    'add',
    'notifications',
    'my_profile',
  ];

  final Map<String, GlobalKey<NavigatorState>> _navigatorKeys = {
    'home': GlobalKey<NavigatorState>(),
    'calendar': GlobalKey<NavigatorState>(),
    'add': GlobalKey<NavigatorState>(),
    'notifications': GlobalKey<NavigatorState>(),
    'my_profile': GlobalKey<NavigatorState>(),
  };

  void _selectTab(String tabItem, int index) {
    if (tabItem == currentPage) {
      _navigatorKeys[tabItem]!.currentState!.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        currentPage = pageKeys[index];
        currentIndex = index;
      });
    }
  }

  final tabs = [
    const Center(child: HomePage()),
    const Center(child: CalendarPage()),
    Container(),
    const Center(child: NotificationsPage()),
    const Center(child: MyProfilePage()),
  ];

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        builder: (context, _) {
          final themeProvider = Provider.of<ThemeProvider>(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'ScholarSync',
            theme: getAppTheme(context, false),
            darkTheme: getAppTheme(context, true),
            themeMode: themeProvider.themeMode,
            home: WillPopScope(
              onWillPop: () async {
                final isFirstRouteInCurrentTab =
                    !await _navigatorKeys[currentPage]!
                        .currentState!
                        .maybePop();
                if (isFirstRouteInCurrentTab) {
                  if (currentPage != 'home') {
                    _selectTab('home', 0);
                    return false;
                  }
                }
                return isFirstRouteInCurrentTab;
              },
              child: Scaffold(
                drawer: const DrawerMenu(),
                body: Stack(children: <Widget>[
                  _buildOffstageNavigator('home'),
                  _buildOffstageNavigator('calendar'),
                  _buildOffstageNavigator('add'),
                  _buildOffstageNavigator('notifications'),
                  _buildOffstageNavigator('my_profile'),
                ]),
                bottomNavigationBar: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 75,
                  decoration: const BoxDecoration(
                    color: CommonColors.primaryGreenColor,
                    boxShadow: [
                      BoxShadow(
                        color: CommonColors.shadowColor,
                        offset: Offset(8, 8),
                        blurRadius: 24,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildNavItem(0, PhosphorIcons.fill.house),
                        _buildNavItem(1, PhosphorIcons.fill.calendarBlank),
                        NavigationAddItem(
                          isSelected: currentIndex == 2,
                          onTap: () {
                            setState(() {
                              currentIndex = 2;
                            });
                          },
                        ),
                        _buildNavItem(3, PhosphorIcons.fill.bell),
                        _buildNavItem(4, PhosphorIcons.fill.user),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );

  Widget _buildOffstageNavigator(String tabItem) {
    return Offstage(
      offstage: currentPage != tabItem,
      child: TabNavigator(
        navigatorKey: _navigatorKeys[tabItem],
        tabItem: tabItem,
      ),
    );
  }

  Widget _buildNavItem(int index, IconData iconName) {
    final isSelected = currentIndex == index;

    return NavigationItem(
      isSelected: isSelected,
      iconName: iconName,
      onTap: () {
        setState(() {
          currentIndex = index;
        });
        _selectTab(pageKeys[index], index);
      },
    );
  }
}
