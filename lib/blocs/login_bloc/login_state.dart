part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

// ignore: must_be_immutable
class LoginSucess extends LoginState {
  User user;
  LoginSucess({
    @required this.user,
  });
}

// ignore: must_be_immutable
class LoginFailed extends LoginState {
  String message;
  LoginFailed({@required this.message});
}
