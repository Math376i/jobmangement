import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counter/settings/cubit/settings_cubit.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_state.dart';
import 'models.dart';
import 'scaffolds/app_scaffold.dart';
import 'scroll_wrapper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    setDefaultSharedPreferencesData();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Your App',
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/mainApp': (context) => JobManagementApp(),
      },
    );
  }
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            final user = User(name: 'John Doe', email: 'johndoe@example.com');
            final jsonString = jsonEncode(user.toJson());
            prefs.setString('user', jsonString);

            Navigator.pushReplacementNamed(context, '/mainApp');
          },
          child: Text('Login'),
        ),
      ),
    );
  }
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: checkLoggedIn(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data!) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Main App'),
            ),
            body: Column(
              children: [
                Center(
                  child: Text('Welcome to the Main App'),
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    child: Text('Logout'),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Text('Login Required'),
            ),
            body: Center(
              child: ElevatedButton(
                onPressed: () {
                  // Navigate back to the login screen
                  Navigator.pushReplacementNamed(context, '/login');
                },
                child: Text('Login'),
              ),
            ),
          );
        }
      },
    );
  }

  Future<bool> checkLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('user');
    if (jsonString != null) {
      return true; // User is logged in
    }
    return false; // User is not logged in
  }
}

class JobManagementApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: checkLoggedIn(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data!) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (_) => AppState(),
              )
            ],
            child: MaterialApp(
              routes: {
                '/login': (context) => LoginPage(),
                '/mainApp': (context) => JobManagementApp(),
              },
              debugShowCheckedModeBanner: false,
              builder: (context, child) => ResponsiveWrapper.builder(
                StretchingScrollWrapper.builder(context, child!),
                defaultScale: true,
                breakpoints: [
                  const ResponsiveBreakpoint.resize(500, name: MOBILE),
                  const ResponsiveBreakpoint.autoScale(600, name: TABLET)
                ],
              ),
              home: const AppScaffold(),
            ),
          );
        } else {
          return const Scaffold(
            body: Center(
              child: Text('Not material app'),
            ),
          );
        }
      },
    );
  }

  Future<bool> checkLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('user');
    if (jsonString != null) {
      return true;
    }
    return false;
  }
}

void setDefaultSharedPreferencesData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (!prefs.containsKey('settings')) {
    print('Setting Default Shared Preferences');
    final settings = Settings(
      apiServerIp: '192.168.1.10',
      apiServerPort: '', // Empty for default
    );
    final jsonString = jsonEncode(settings.toJson());
    prefs.setString('settings', jsonString);
  }
}

// OLD
// class JobManagementApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(
//           create: (_) => AppState(),
//         ),
//       ],
//       child: MaterialApp(
//         theme: ThemeData(
//           brightness: Brightness.light,
//         ),
//         darkTheme: ThemeData(
//           brightness: Brightness.dark,
//         ),
//         themeMode: ThemeMode.light,
//         debugShowCheckedModeBanner: false,
//         builder: (context, child) => ResponsiveWrapper.builder(
//           StretchingScrollWrapper.builder(context, child!),
//           defaultScale: true,
//           breakpoints: [
//             const ResponsiveBreakpoint.resize(500, name: MOBILE),
//             const ResponsiveBreakpoint.autoScale(600, name: TABLET)
//           ],
//         ),
//         home: const AppScaffold(),
//       ),
//     );
//   }

//   Future<bool> checkLoggedIn() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     final jsonString = prefs.getString('user');
//     if (jsonString != null) {
//       return true;
//     }
//     return false;
//   }
// }