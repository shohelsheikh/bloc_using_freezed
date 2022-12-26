import 'package:bloc_with_freezed_with_test/data/model/login_model/login_request.dart';
import 'package:bloc_with_freezed_with_test/data/model/login_model/login_response.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:bloc_with_freezed_with_test/login/bloc/bloc.dart';
import 'package:flutter_test/flutter_test.dart';

Login_response login_success_response =
    new Login_response(status: 200, msg: "Suceesss");

Login_response login_fail_response =
    new Login_response(status: 400, msg: "fail");

// LoginRequest loginRequest =
//     new LoginRequest(email: "ss@gmailcom",password: "[asss",token: "token");

Future<Login_response?> mockSuccessLoginHandler(
    LoginRequest loginRequest) async {
  return login_success_response;
}

Future<Login_response?> mockFailLoginHandler(LoginRequest loginRequest) async {
  return login_fail_response;
}

main() {
  blocTest<LoginBloc, LoginState>("Login Test",
      build: () => LoginBloc(testLoginHandler: mockSuccessLoginHandler),
      act: (bloc) => bloc.add(LoginToAccount()),
      verify: (loginState) =>
          expect(loginState.state, LoginState.succeed()));
}
