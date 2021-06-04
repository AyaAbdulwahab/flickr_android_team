import 'package:flickr/Models/user_model.dart';
import 'package:flutter/material.dart';

import 'package:flickr/Views/nav.dart';
import 'package:flickr/Views/welcome_page.dart';
import 'package:provider/provider.dart';

/// The [SplashScreen] is the root widget of the app which checks if a user is authenticated or not
/// **In order to prevent unautorized users form entering the app if a user signned out**

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyModel>(context);
    if (!user.isAuth) {
      /// If the user is not authenticated direct him to the welcome page
      return GetStarted();
    } else {
      /// Else direct him to the home page
      return NavBar();
    }
  }
}
