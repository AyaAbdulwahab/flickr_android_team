import 'package:flickr/View_Model/user_view_model.dart';
import 'package:flutter/material.dart';

import 'package:flickr/main.dart';
import 'package:flickr/Views/nav.dart';
import 'package:flickr/Views/welcome_page.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyModel>(context);
    // print(user.getToken());
    print(user.isAuth);
    if (!user.isAuth) {
      /// If the user is not authenticated direct him to the welcome page
      return GetStarted();
    } else {
      /// Else direct him to the home page
      return NavBar();
    }
  }
}
