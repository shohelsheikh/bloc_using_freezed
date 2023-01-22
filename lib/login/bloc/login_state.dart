import 'package:freezed_annotation/freezed_annotation.dart';

import '../../utils/field_status.dart';

part 'login_state.freezed.dart';

@freezed
abstract class LoginState implements _$LoginState {
  const LoginState._();

// test
  const factory LoginState(
      {String email,
      String password,
      FieldStatus emailValidation,
      FieldStatus passwordValidation,
      bool isLoading,
      bool isModified,
      bool isSucceed,
      bool isFailed,
      String error,
      String successMsg}) = _LoginState;

  bool? isBusy() => isLoading;

  List<Object> get props =>
      [email.toString(), password.toString(), successMsg.toString()];

  static LoginState initial() => const LoginState(
      email: "",
      password: "",
      emailValidation: FieldStatus(true, null),
      passwordValidation: FieldStatus(true, null),
      isLoading: false,
      isModified: false,
      isSucceed: false,
      isFailed: false,
      error: "",
      successMsg: "");

  static LoginState loading(String email, String password) => LoginState(
      email: email,
      password: password,
      emailValidation: const FieldStatus(true, null),
      passwordValidation: const FieldStatus(true, null),
      isLoading: true,
      isModified: false,
      isSucceed: false,
      isFailed: false,
      error: "",
      successMsg: "");

  static LoginState failed(String email, String password, String error) =>
      LoginState(
          email: email,
          password: password,
          emailValidation: const FieldStatus(true, null),
          passwordValidation: const FieldStatus(true, null),
          isLoading: false,
          isModified: true,
          isSucceed: false,
          isFailed: true,
          error: error,
          successMsg: "");

  static LoginState succeed() => LoginState(
        successMsg: "Suceesss",
      );
}
