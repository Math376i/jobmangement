import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counter/app_state.dart';
import 'package:flutter_counter/colors.dart';
import 'package:flutter_counter/jobapi_server.dart';
import 'package:flutter_counter/login/login.dart';
import 'package:flutter_counter/models.dart';
import 'package:flutter_counter/shared_prefs.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final TextEditingController _email = TextEditingController();
    final TextEditingController _passkey = TextEditingController();

    void _submitForm() async {
      if (_formKey.currentState!.validate()) {
        final String email = _email.text;
        final String passkey = _passkey.text;
        final user = User(email: email, passkey: passkey);
        final isOk =
            await BlocProvider.of<LoginCubit>(context).submitLogin(user);
        if (isOk) {
          Navigator.pushReplacementNamed(context, '/mainApp');
        }
        if (!isOk) {
          print('Wrong Username or Password');
        }
      }
    }

    void _submitRegister() async {
      if (_formKey.currentState!.validate()) {
        final String email = _email.text;
        final String passkey = _passkey.text;
        final user = User(email: email, passkey: passkey);
        final isOk =
            await BlocProvider.of<LoginCubit>(context).submitRegister(user);
        if (isOk) {
          Navigator.pushReplacementNamed(context, '/mainApp');
        }
        if (!isOk) {
          print('Wrong Username or Password');
        }
      }
    }

    return BlocBuilder<LoginCubit, LoginState>(builder: ((context, state) {
      if (state is LoginInitial) {
        return Scaffold(
          body: Container(
            decoration: const BoxDecoration(color: ColorDef.company100),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    "JobManagement",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 50,
                        color: ColorDef.company700),
                  ),
                  Form(
                    key: _formKey,
                    child: SizedBox(
                      width: 350,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              child: TextFormField(
                                controller: _email,
                                maxLines: 1,
                                decoration: const InputDecoration(
                                  labelText: 'Email',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                  ),
                                ),
                                validator: (value) {
                                  bool email = _isValidEmail(value!);
                                  if (value == null ||
                                      value.isEmpty ||
                                      !email) {
                                    return 'Invalid Email';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                              ),
                              child: TextFormField(
                                controller: _passkey,
                                obscureText: true,
                                maxLines: 1,
                                decoration: const InputDecoration(
                                  labelText: 'Password',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter Password';
                                  } else if (value.length < 8) {
                                    return 'Password must be at least 8 characters long';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: _submitRegister,
                                child: const Text(
                                  'Register',
                                  style: TextStyle(
                                      decoration: TextDecoration.underline),
                                ),
                              ),
                              SizedBox(
                                width: 200,
                                child: ElevatedButton(
                                  onPressed: _submitForm,
                                  child: const Text('Login'),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(),
                ],
              ),
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

  bool _isValidEmail(String email) {
    // Regex pattern to match a valid email address
    final RegExp emailRegex = RegExp(
      r'^[\w-]+(?:\.[\w-]+)*@(?:[\w-]+\.)+[a-zA-Z]{2,7}$',
    );
    return emailRegex.hasMatch(email);
  }
}
