import 'package:bloc_with_freezed_with_test/data/model/login_model/login_request.dart';
import 'package:bloc_with_freezed_with_test/data/model/login_model/login_request.dart';
import 'package:bloc_with_freezed_with_test/data/model/login_model/login_response.dart';
import 'package:bloc_with_freezed_with_test/data/repository/authentication_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/field_status.dart';
import 'bloc.dart';

typedef LoginHandler = Future<Login_response?> Function(
    LoginRequest loginRequest);

class LoginBloc2 extends Bloc<LoginEvent, LoginState> {
  LoginRequest loginTestRequest =
      new LoginRequest(email: "test@gmai222222l.com", password: "", token: "12223232320033");
  LoginRequest loginRequest = new LoginRequest();

  LoginHandler? testLoginHandler;
  var authRepo = AuthenticationRepo();

  Future<Login_response?> _loginHandler(LoginRequest loginRequest) async {
    final decoded = loginRequest.toJson();

    var result = await authRepo.login_apiAPI(
      decoded,
    );

    return result;
  }


  bool get isValid =>
      state.email.toString().isNotEmpty &&
      state.email.toString().trim().isNotEmpty &&
      state.password.toString().isNotEmpty &&
      state.password.toString().trim().isNotEmpty;

  LoginBloc2({this.testLoginHandler}) : super(LoginState.initial())

  {



    on<EmailChanged>((event, emit) async {
      bool isValid = event.email.isNotEmpty && event.email.trim().isNotEmpty;
      emit(state.copyWith(
          isModified: true,
          isFailed: false,
          isSucceed: false,
          email: event.email,
          emailValidation:
              FieldStatus(isValid, (!isValid ? 'Email is required' : null))));
    });

    on<PasswordChanged>((event, emit) async {
      bool isValid =
          event.password.isNotEmpty && event.password.trim().isNotEmpty;
      emit(state.copyWith(
          isModified: true,
          isSucceed: false,
          isFailed: false,
          password: event.password,
          passwordValidation: FieldStatus(
              isValid, (!isValid ? 'Password is required' : null))));
    });

    on<LoginToAccount>((event, emit) async {
      emit(state.copyWith(
        isModified: true,
      ));

      if (testLoginHandler != null) {
        // test input

        if (loginTestRequest.email == "" ||
            loginTestRequest.password == "" ||
            loginTestRequest.token == "") {
          emit(LoginState.failed(loginTestRequest.email,
              loginTestRequest.password, "Failed to login"));
        } else {
          loginRequest = loginTestRequest;
        }
      } else {
        loginRequest.email = state.email.toString();
        loginRequest.password = state.password.toString();
        loginRequest.token = "token123";
      }

      emit(LoginState.loading(
          state.email.toString(), state.password.toString()));

      Login_response? otp =
          await (testLoginHandler ?? _loginHandler)(loginRequest);

      if (otp == null) {
        emit(LoginState.failed(state.email.toString(),
            state.password.toString(), "Failed to login"));
      } else if (otp.status != 200) {
        emit(LoginState.failed(state.email.toString(),
            state.password.toString(), otp.msg.toString()));
      } else if (otp.status == 200) {
        emit(LoginState.succeed());
      }
    });

    //
    // on<RunLongRunningStreamedComplexEvent>((event, emit) async {
    //   emit(HomeLoadingState('Running long running streamed complex operation...'));
    //   await for (final result in _fakeNetworkService.longRunningComplexStream()) {
    //     emit(HomeLoadingState(result.message, icon: result.icon));
    //   }
    //   emit(HomeLoadedState());
    // });
  }
}
