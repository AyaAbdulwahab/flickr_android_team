import 'package:flickr/Models/user_model.dart';
import 'package:flickr/Views/about_menu.dart';
import 'package:flickr/Views/credits.dart';
import 'package:flickr/Views/login.dart';
import 'package:flickr/Views/nav.dart';
import 'package:flickr/Views/privacy_settings.dart';

import 'package:flickr/Views/sign_up.dart';
import 'package:flickr/Views/welcome_page.dart';
import 'package:flickr/Views/splash_screen.dart';
import 'package:flickr/Views/you.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

/// ## The root of the application
/// all the navigation roots are determined here
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MyModel>(
      create: (context) => MyModel(),
      child: MaterialApp(
        title: 'Flickr',
        theme: ThemeData(fontFamily: 'ProximaNova'),
        initialRoute: '/',
        routes: {
          '/': (context) => SplashScreen(), //WelcomePage
          '/welcome_page': (context) => GetStarted(),
          '/home': (context) => NavBar(),
          '/login': (context) => Login(),
          '/sign_up': (context) => SignUp(),
          '/you_page': (context) => YouPage(),
          '/About_Menu': (context) => AboutMenu(),
          '/credits': (context) => Credits(),
          '/privacy': (context) => Privacy()
        },
      ),
    );
  }
}
