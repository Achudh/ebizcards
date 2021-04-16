import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ebizcards/repo/user_repo.dart';
import 'package:equatable/equatable.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  UserRepo userRepo;
  HomePageBloc({this.userRepo}) : super(HomePageInitial());
  // HomePageState get initialState => SignOutInitial();
  @override
  Stream<HomePageState> mapEventToState(
    HomePageEvent event,
  ) async* {
    if (event is SignOutButtonPressed) {
      yield SignOutLoading();
      await userRepo.signOut();
      yield SignOutSucess();
    }
  }
}
