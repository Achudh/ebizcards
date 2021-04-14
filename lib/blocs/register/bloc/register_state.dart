part of 'register_bloc.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSucess extends RegisterState {
  User user;
  RegisterSucess({
    @required this.user,
  });
}

class RegisterFailed extends RegisterState {
  String message;
  RegisterFailed({
    @required this.message,
  });
}
