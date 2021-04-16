import 'package:flutter/material.dart';

import 'package:ebizcards/repo/user_repo.dart';

class SignUpWrapper extends StatelessWidget {
  UserRepo userRepo;
  SignUpWrapper({
    Key key,
    @required this.userRepo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class SignUp extends StatelessWidget {
  const SignUp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Sign Up'),
      ),
    );
  }
}
