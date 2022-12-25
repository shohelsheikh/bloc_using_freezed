import 'package:bloc_with_freezed_with_test/data/model/login_model/login_request.dart';
import 'package:bloc_with_freezed_with_test/data/model/login_model/login_request.dart';
import 'package:bloc_with_freezed_with_test/data/model/login_model/login_response.dart';
import 'package:bloc_with_freezed_with_test/data/repository/authentication_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/field_status.dart';
import 'bloc.dart';

typedef LoginHandler = Future<Login_response?> Function(LoginRequest loginRequest);

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginHandler? testLoginHandler;
  var authRepo = AuthenticationRepo();

  Future<Login_response?> _loginHandler(
      LoginRequest otp_request ) async {

    final decoded = otp_request.toJson();

    var result = await authRepo.enterprise_login_apiAPI(
      decoded,
    );

    return result;
  }

  bool get isValid =>
      state.email.isNotEmpty &&
      state.email.trim().isNotEmpty &&
      state.password.isNotEmpty &&
      state.password.trim().isNotEmpty;

  LoginBloc({this.testLoginHandler}) : super(LoginState.initial()) {
    // on<LoginEvent>(
    //       (event, emit) => emit(
    //     HomeLoadedState(),
    //   ),
    // );

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

      LoginRequest otp_request = new LoginRequest();
      otp_request.email = state.email;
      otp_request.password =  state.password;
      otp_request.token = "";

      emit(LoginState.loading(state.email, state.password));

      Login_response? otp = await (testLoginHandler ??
          _loginHandler)(otp_request);

      if (otp == null) {
        emit(LoginState.failed(state.email, state.password, "Failed to login"));
      } else if (otp.status != 200) {
        emit(
            LoginState.failed(state.email, state.password, otp.msg.toString()));
      } else if (otp.status == 200) {
        emit(LoginState.succeed(
           otp.msg.toString()));
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
