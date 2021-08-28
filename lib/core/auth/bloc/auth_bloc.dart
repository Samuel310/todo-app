import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo/core/auth/repository/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository;
  AuthBloc({required this.repository}) : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is OnSignInBtnClicked) {
      try {
        yield SigningInState();
        await repository.login(email: event.email, password: event.password);
        yield AuthInitial();
      } catch (e) {
        print(e.toString());
        yield ErrorState(errorMsg: e.toString());
      }
    } else if (event is OnRegisterBtnClicked) {
      try {
        yield RegisteringState();
        await repository.register(email: event.email, password: event.password, name: event.name);
        yield AuthInitial();
      } catch (e) {
        yield ErrorWhileRegisteringState(errorMsg: e.toString());
      }
    } else if (event is OnSignOutBtnClicked) {
      await repository.logout();
      yield AuthInitial();
    } else if (event is OnForgotPasswordBtnClicked) {
      try {
        yield SendingRecoveryEmailState();
        await repository.forgotPassword(email: event.email);
        yield RecoveryEmailSentState();
      } catch (e) {
        yield ErrorState(errorMsg: e.toString());
      }
    }
  }
}
