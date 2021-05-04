import 'package:flickr/Views/about_menu.dart';
import 'package:flickr/Views/credits.dart';
import 'package:flickr/Views/login.dart';
import 'package:flickr/Views/nav.dart';
import 'package:flickr/Views/sign_up.dart';
import 'package:flickr/Views/home.dart';
import 'package:flickr/Views/About.dart';
import 'package:flickr/Views/welcome_page.dart';
import 'package:flickr/Views/splash_screen.dart';
import 'package:flickr/Views/you.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MyModel>(
      create: (context) => MyModel(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            primarySwatch: Colors.blue,
            fontFamily: 'ProximaNova'),
        //home: YouPage(),
        initialRoute: '/',
        routes: {
          '/': (context) => SplashScreen(), //WelcomePage
          '/home': (context) => NavBar(), //WelcomePage
          '/login': (context) => Login(),
          '/sign_up': (context) => SignUp(),
          '/you_page': (context) => YouPage(),
          '/About_Menu': (context) => AboutMenu(),
          '/credits': (context) => Credits()
        },
      ),
    );
  }
}

class MyModel with ChangeNotifier {
  bool isAuth = false;

  void authUser() {
    isAuth = true;
    notifyListeners();
  }

  void unAuthUser() {
    isAuth = false;
    notifyListeners();
  }
}
