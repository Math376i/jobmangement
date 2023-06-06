import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counter/colors.dart';
import 'package:flutter_counter/login/view/login_page.dart';
import 'package:flutter_counter/settings/cubit/settings_cubit.dart';
import 'package:flutter_counter/shared_prefs.dart';
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
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    setDefaultSharedPreferencesData();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'DIN',
        primaryColor: ColorDef.company,
        primaryColorDark: ColorDef.company700,
        primaryColorLight: ColorDef.company100,
      ),
      title: 'Job Management',
      initialRoute: '/mainApp',
      routes: {
        '/login': (context) => const LoginPage(),
        '/mainApp': (context) => const MainApp(),
      },
      builder: (context, child) => ResponsiveWrapper.builder(
        StretchingScrollWrapper.builder(context, child!),
        defaultScale: true,
        breakpoints: [
          const ResponsiveBreakpoint.resize(500, name: MOBILE),
          const ResponsiveBreakpoint.autoScale(600, name: TABLET)
        ],
      ),
      home: MainApp(),
    );
  }
}

// class LoginPage extends StatelessWidget {
//   const LoginPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () async {
//             SharedPreferences prefs = await SharedPreferences.getInstance();
//             final user = User(name: 'John Doe', email: 'johndoe@example.com');
//             final jsonString = jsonEncode(user.toJson());
//             prefs.setString('user', jsonString);

//             Navigator.pushReplacementNamed(context, '/mainApp');
//           },
//           child: Text('Login'),
//         ),
//       ),
//     );
//   }
// }

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: SavedData.checkLoggedIn(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data!) {
          return MultiProvider(providers: [
            ChangeNotifierProvider(
              create: (_) => AppState(),
            )
          ], child: AppScaffold());
        } else if (snapshot.hasData && snapshot.data != true) {
          WidgetsBinding.instance!.addPostFrameCallback((_) {
            Navigator.pushReplacementNamed(context, '/login');
          });
          return Container();
        } else {
          return Container(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Future<bool> checkLoggedIn() async {
    return await SavedData.checkLoggedIn();
  }
}

void setDefaultSharedPreferencesData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (!prefs.containsKey('settings')) {
    print('Setting Default Shared Preferences');
    final settings = Settings(
      apiServerIp: '10.178.88.58',
      apiServerPort: '', // Empty for default
    );
    final jsonString = jsonEncode(settings.toJson());
    prefs.setString('settings', jsonString);
  }
}

// Less old
// class JobManagementApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: checkLoggedIn(),
//       builder: (context, snapshot) {
//         if (snapshot.hasData && snapshot.data!) {
//           return MultiProvider(
//             providers: [
//               ChangeNotifierProvider(
//                 create: (_) => AppState(),
//               )
//             ],
//             child: MaterialApp(
//               title: 'Job Management',
//               routes: {
//                 '/login': (context) => LoginPage(),
//                 '/mainApp': (context) => JobManagementApp(),
//               },
//               debugShowCheckedModeBanner: false,
//               builder: (context, child) => ResponsiveWrapper.builder(
//                 StretchingScrollWrapper.builder(context, child!),
//                 defaultScale: true,
//                 breakpoints: [
//                   const ResponsiveBreakpoint.resize(500, name: MOBILE),
//                   const ResponsiveBreakpoint.autoScale(600, name: TABLET)
//                 ],
//               ),
//               home: const AppScaffold(),
//             ),
//           );
//         } else {
//           return const Scaffold(
//             body: Center(
//               child: Text('Not material app'),
//             ),
//           );
//         }
//       },
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