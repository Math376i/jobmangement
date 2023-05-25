import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counter/login/login.dart';
import 'package:flutter_counter/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(builder: ((context, state) {
      if (state is LoginInitial) {
        return const Center(
          child: Text('Login Initial'),
        );
      }
      if (state is LoginRequired) {
        return Scaffold(
          body: Center(
            child: ElevatedButton(
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                final user =
                    User(name: 'John Doe', email: 'johndoe@example.com');
                final jsonString = jsonEncode(user.toJson());
                prefs.setString('user', jsonString);

                Navigator.pushReplacementNamed(context, '/mainApp');
              },
              child: Text('Login'),
            ),
          ),
        );
      } else {
        return const Center(
          child: Text('Should never get to this'),
        );
      }
    }));
  }
}
