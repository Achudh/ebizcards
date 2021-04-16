import 'package:ebizcards/screens/home_screen.dart';
import 'package:ebizcards/screens/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ebizcards/blocs/login_bloc/login_bloc.dart';
import 'package:ebizcards/repo/user_repo.dart';

class SignInPageWrapper extends StatelessWidget {
  final UserRepo userRepo;
  const SignInPageWrapper({
    @required this.userRepo,
  });
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(userRepo: userRepo),
      child: SignIn(userRepo: userRepo),
    );
  }
}

// ignore: must_be_immutable
class SignIn extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  LoginBloc loginBloc;
  UserRepo userRepo;
  SignIn({@required this.userRepo});
  @override
  Widget build(BuildContext context) {
    loginBloc = BlocProvider.of<LoginBloc>(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(5.0),
            child: BlocListener<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state is LoginSucess) {
                  navigateToHomeScreen(context, state.user);
                }
              },
              child: BlocBuilder<LoginBloc, LoginState>(
                // ignore: missing_return
                builder: (context, state) {
                  if (state is LoginInitial) {
                    return buildInitialUi();
                  } else if (state is LoginLoading) {
                    return buildLoadingUi();
                  } else if (state is LoginSucess) {
                    emailController.text = '';
                    passwordController.text = '';
                    return Container();
                  }
                },
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(5.0),
            child: TextField(
              controller: emailController,
              decoration: InputDecoration(
                  errorStyle: TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                  hintText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
          ),
          Container(
            padding: EdgeInsets.all(5.0),
            child: TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                  errorStyle: TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                  hintText: 'Password'),
              keyboardType: TextInputType.visiblePassword,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                child: ElevatedButton(
                  // color: Colors.cyan,
                  child: Text("Login"),
                  // textColor: Colors.white,
                  onPressed: () async {
                    loginBloc.add(
                      SignInButtonPressed(
                        email: emailController.text,
                        password: passwordController.text,
                      ),
                    );
                  },
                ),
              ),
              Container(
                child: ElevatedButton(
                  // color: Colors.cyan,
                  child: Text("Sign Up"),
                  // textColor: Colors.white,
                  onPressed: () {
                    navigateToSignUpScreen(context);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildInitialUi() {
    return Container(
      padding: EdgeInsets.all(5.0),
      child: Text(
        "Enter Login Credentials",
        style: TextStyle(
          fontSize: 30.0,
          color: Colors.teal,
        ),
      ),
    );
  }

  Widget buildLoadingUi() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildFailureUi(String message) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(5.0),
          child: Text(
            "Fail $message",
            style: TextStyle(color: Colors.red),
          ),
        ),
        buildInitialUi(),
      ],
    );
  }

  void navigateToHomeScreen(BuildContext context, User user) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      // return HomePageParent(user: user, userRepository: userRepository);
      return HomePageWrapper(
        user: user,
        userRepo: userRepo,
      );
    }));
  }

  void navigateToSignUpScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      // return SignUpPageParent(userRepository: userRepository);
      return SignUp();
    }));
  }
}
