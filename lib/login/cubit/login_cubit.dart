import 'package:flutter_bloc/flutter_bloc.dart';
import '../Auth/auth_repository.dart';
import '../Auth/form_submission_status.dart';
import '../view/login_page.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepo;

  LoginBloc({required this.authRepo}) : super(LoginState());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    // Username updated
    if (event is LoginUsernameChanged) {
      yield state.copyWith(username: event.username, password: '');

      // Password updated
    } else if (event is LoginPasswordChanged) {
      yield state.copyWith(password: event.password, username: '');

      // Form submitted
    } else if (event is LoginSubmitted) {
      yield state.copyWith(
          formStatus: FormSubmitting(), username: '', password: '');

      try {
        await authRepo.login();
        yield state.copyWith(
            formStatus: SubmissionSuccess(), username: '', password: '');
      } catch (e) {
        yield state.copyWith(
            formStatus: SubmissionFailed("not found" as Exception),
            username: '',
            password: '');
      }
    }
  }
}
