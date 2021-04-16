import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ebizcards/repo/user_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserRepo userRepo;
  LoginBloc({this.userRepo}) : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is SignInButtonPressed) {
      yield LoginLoading();
      try {
        var user = await userRepo.signIn(event.email, event.password);
        yield LoginSucess(user: user);
      } catch (e) {
        yield LoginFailed(message: e.toString());
      }
    }
  }
}
