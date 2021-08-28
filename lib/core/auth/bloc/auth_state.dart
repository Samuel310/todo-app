part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class SigningInState extends AuthState {}

class RegisteringState extends AuthState {}

class SendingRecoveryEmailState extends AuthState {}

class RecoveryEmailSentState extends AuthState {}

class ErrorState extends AuthState {
  final String errorMsg;
  ErrorState({required this.errorMsg});
}

class ErrorWhileRegisteringState extends AuthState {
  final String errorMsg;
  ErrorWhileRegisteringState({required this.errorMsg});
}
