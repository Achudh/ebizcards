import 'package:ebizcards/blocs/auth_bloc/auth_bloc.dart';
import 'package:ebizcards/repo/user_repo.dart';
import 'package:ebizcards/screens/home_screen.dart';
import 'package:ebizcards/screens/signin_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => AuthBloc(),
        child: Root(),
      ),
    );
  }
}

// ignore: must_be_immutable
class Root extends StatelessWidget {
  UserRepo userRepo;
  User user;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is UnAuthenticateState) {
          return SignInPageWrapper(
            userRepo: userRepo,
          );
        }
        if (state is AuthenticateState) {
          return HomePageWrapper(
            user: user,
            userRepo: userRepo,
          );
        }
        return SignInPageWrapper(userRepo: userRepo);
      },
    );
  }
}
