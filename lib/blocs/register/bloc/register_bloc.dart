import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ebizcards/repo/user_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  UserRepo userRepo;
  RegisterBloc({this.userRepo}) : super(RegisterInitial());

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is SignUpButtonPressed) {
      yield RegisterLoading();
      try {
        var user = await userRepo.signUp(event.email, event.password);
        yield RegisterSucess(user: user);
      } catch (e) {
        yield RegisterFailed(message: e.toString());
      }
    }
  }
}
