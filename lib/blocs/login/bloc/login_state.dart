part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSucess extends LoginState {
  User user;
  LoginSucess({
    @required this.user,
  });
}

class LoginFailed extends LoginState {
  String message;
  LoginFailed({@required this.message});
}
