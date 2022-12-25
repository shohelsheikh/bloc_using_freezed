import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_event.freezed.dart';

@freezed
abstract class LoginEvent with _$LoginEvent {

  // props
  const factory LoginEvent.emailChanged(
      String email) = EmailChanged;

  // props
  const factory LoginEvent.passwordChanged(
      String password) = PasswordChanged;

  // actions
  const factory LoginEvent.login() = LoginToAccount;



}
