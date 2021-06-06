import 'package:flutter/cupertino.dart';

/// class [MyModel] is the main model for the user that checks if a user is
/// currently authorized to endter the app by the [isAuth] boolean which is
/// set at both the sign in and sign up and reset at the sign out.
/// the ChangeNotifier is used to inform the root of the app if any changes
/// concerning the authentication had happened
///
/// Also it keeps track of the id ,token and followers of the user.
class MyModel with ChangeNotifier {
  bool isAuth = false;
  String _token;
  List followers = [];

  String _id;
  void setID(String id) {
    _id = id;
  }

  String getID() {
    return _id;
  }

  void setFollowers(List a) {
    followers = a;
  }

  List getFollowers() {
    return followers;
  }

  void setToken(String token) {
    print(token);
    _token = token;
  }

  String getToken() {
    return _token;
  }

  void authUser() {
    isAuth = true;
    notifyListeners();
  }

  void unAuthUser() {
    isAuth = false;
    notifyListeners();
  }
}
