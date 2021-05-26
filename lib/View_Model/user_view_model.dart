import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flickr/Constants/constants.dart';
import 'package:flutter/cupertino.dart';

/// class [MyModel] // have 2 functions to check if the current user is
/// authenticated to enter the app of not
/// the ChangeNotifier is used to inform the root of the app i any changes
/// conserning the authentication had happened
class MyModel with ChangeNotifier {
  bool isAuth = false;
  String _token;
  void setToken(String token) {
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

Future<Map<String, dynamic>> signUp(String firstName, String lastName, int age,
    String email, String password, String displayName) async {
  try {
    final response = await Dio().post(EndPoints.baseUrl + '/user/sign-up',
        options: Options(validateStatus: (status) {
      return true;
    }),
        data: json.encode({
          "firstName": firstName,
          "lastName": lastName,
          "displayName": displayName,
          "age": age,
          "email": email,
          "password": password
        }));
    if (response.data['token'] != null) {
      return response.data;
    } else {
      print(response.data);
    }
  } catch (error) {
    // throw HttpException(error.toString());
    print(error.toString());
  }
}
