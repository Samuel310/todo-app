part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class OnSignInBtnClicked extends AuthEvent {
  final String email;
  final String password;
  OnSignInBtnClicked({required this.email, required this.password});
}

class OnRegisterBtnClicked extends AuthEvent {
  final String name;
  final String email;
  final String password;
  OnRegisterBtnClicked({required this.name, required this.email, required this.password});
}

class OnForgotPasswordBtnClicked extends AuthEvent {
  final String email;
  OnForgotPasswordBtnClicked({required this.email});
}

class OnSignOutBtnClicked extends AuthEvent {}
