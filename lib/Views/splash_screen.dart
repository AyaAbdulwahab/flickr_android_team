import 'package:flickr/Views/login.dart';
import 'package:flickr/Views/nav.dart';
import 'package:flickr/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyModel>(context);
    print(user.isAuth);
    if (!user.isAuth) {
      /// If the user is not authenticated direct him to the login page
      /// to be changed to the welcome screen***
      return Login();
    } else {
      return NavBar();
    }
  }
}
