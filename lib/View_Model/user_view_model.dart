import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flickr/Constants/constants.dart';
import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;


/// class [MyModel] // have 2 functions to check if the current user is
/// authenticated to enter the app of not
/// the ChangeNotifier is used to inform the root of the app i any changes
/// conserning the authentication had happened
class MyModel with ChangeNotifier {
  bool isAuth = false;
  String _token;

  String _id;
  void setID(String id) {
    _id = id;
  }

  String getID() {
    return _id;
  }

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

    if (response.statusCode == 200) {
      if (response.data['token'] != null) {
        return response.data;
      } else {
        print(response.data);
      }

    }
  } catch (error) {
    // throw HttpException(error.toString());
    print(error.toString());
  }
}


/// This function get the user real name through his/her [id] and [token]
/// And if the user's name is more than 15 chars, we only take the first
/// 15 chars and remove any whitespace
Future<dynamic> getUsername(String id, String token) async {
  var req = await http.get(
    (Uri.parse(EndPoints.baseUrl + '/user/' + id + '/real-name')),
    headers: {"authorization": "Bearer " + token},
  );
  if (req.statusCode == 200) {
    String data = req.body;
    print(data);
    Map<String, dynamic> info = jsonDecode(data)['data'];
    String name = info["firstName"] + " " + info["lastName"];
    return (name.length >= 19) ? name.substring(0, 15).trim() : name.trim();
  }
}

/// This function get the number of followers of a user through
/// his/her [id] and [token]
Future<dynamic> getNoOfFollowers(String id, String token) async {
  var req = await http.get(
    (Uri.parse(EndPoints.baseUrl + '/user/' + id + '/following')),
    headers: {"authorization": "Bearer " + token},
  );
  if (req.statusCode == 200) {
    String data = req.body;
    print(data);
    int noOfFollowing = jsonDecode(data)["count"];
    return noOfFollowing;
  }
}

