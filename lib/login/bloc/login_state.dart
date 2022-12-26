import 'package:freezed_annotation/freezed_annotation.dart';

import '../../utils/field_status.dart';

part 'login_state.freezed.dart';

@freezed
abstract class LoginState implements _$LoginState {
  const LoginState._();
// test
  const factory LoginState(
      {required String email,
      required String password,
      required FieldStatus emailValidation,
      required FieldStatus passwordValidation,
      required bool isLoading,
      required bool isModified,
      required bool isSucceed,
      required bool isFailed,
        required String error,
        required String successMsg}) = _LoginState;

  bool isBusy() => isLoading;

  static LoginState initial() => const LoginState(
      email: "",
      password: "",
      emailValidation: FieldStatus(true, null),
      passwordValidation: FieldStatus(true, null),
      isLoading: false,
      isModified: false,
      isSucceed: false,
      isFailed: false,
      error:"",
      successMsg:""
  );

  static LoginState loading(String email, String password) => LoginState(
      email: email,
      password: password,
      emailValidation: const FieldStatus(true, null),
      passwordValidation: const FieldStatus(true, null),
      isLoading: true,
      isModified: false,
      isSucceed: false,
      isFailed: false,
      error:"",
      successMsg:"");

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

  static LoginState succeed(
    String successMsg,
  ) =>
      LoginState(
          email: "",
          password: "",
          emailValidation: FieldStatus(true, null),
          passwordValidation: FieldStatus(true, null),
          isLoading: false,
          isModified: true,
          isSucceed: true,
          isFailed: false,
          error:"",
        successMsg:successMsg,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoginState && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}
