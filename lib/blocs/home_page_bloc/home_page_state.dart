part of 'home_page_bloc.dart';

abstract class HomePageState extends Equatable {
  const HomePageState();

  @override
  List<Object> get props => [];
}

class HomePageInitial extends HomePageState {}

class SignOutInitial extends HomePageState {}

class SignOutLoading extends HomePageState {}

class SignOutSucess extends HomePageState {}
