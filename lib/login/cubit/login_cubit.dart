import 'package:bloc/bloc.dart';
import 'package:flutter_counter/jobapi_server.dart';
import 'package:flutter_counter/models.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<bool> submitLogin(User user) async {
    return await Server.login(user);
  }

  submitRegister(User user) async {
    return await Server.register(user);
  }
}
