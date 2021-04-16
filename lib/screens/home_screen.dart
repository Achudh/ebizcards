import 'package:ebizcards/blocs/home_page_bloc/home_page_bloc.dart';
import 'package:ebizcards/blocs/login_bloc/login_bloc.dart';
import 'package:ebizcards/repo/user_repo.dart';
import 'package:ebizcards/screens/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class HomePageWrapper extends StatelessWidget {
  User user;
  UserRepo userRepo;
  HomePageWrapper({@required this.user, @required this.userRepo});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(userRepo: userRepo),
      child: Home(user: user, userRepo: userRepo),
    );
  }
}

// ignore: must_be_immutable
class Home extends StatelessWidget {
  User user;
  HomePageBloc homePageBloc;
  UserRepo userRepo;
  Home({@required this.user, @required this.userRepo});
  @override
  Widget build(BuildContext context) {
    homePageBloc = BlocProvider.of<HomePageBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Title'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              homePageBloc.add(SignOutButtonPressed());
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Text(user.uid),
          ),
          BlocListener<HomePageBloc, HomePageState>(
            listener: (context, state) {
              if (state is SignOutSucess) {
                // navigateToSignUpPage(context);
              }
            },
            child: BlocBuilder<HomePageBloc, HomePageState>(
              builder: (context, state) {
                if (state is SignOutInitial) {
                  return Container();
                } else if (state is SignOutSucess) {
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void navigateToSignUpPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return SignUpWrapper(userRepo: userRepo);
    }));
  }
}
