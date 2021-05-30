import 'dart:convert';
import 'dart:io';
import '../Models/user_model.dart';
import 'package:dio/dio.dart';
import 'package:flickr/Constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

/// class [MyModel] // have 2 functions to check if the current user is
/// authenticated to enter the app of not
/// the ChangeNotifier is used to inform the root of the app if any changes
/// concerning the authentication had happened
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


/// Sends a post request containing [email] and [password] of the user to the url, and returns the response
logIn(String email, String password) async {
  final response = await Dio().post(
      EndPoints.mockBaseUrl + '/user/sign-in?ID=1',
      options: Options(
          validateStatus: (_) {
            return true;
          },
          responseType: ResponseType.json),
      data: jsonEncode({
        "email": email,
        "password": password,
      }));
  print(response);
  return response;
}


/// Sends PATCH request with [token] and [ID] as headers for updating privacy settings using the [PrivacyInfo] parameter
///
/// Returns [PrivacyInfo] Object with the new privacy settings obtained from the response
Future <PrivacyInfo> updatePrivacy(PrivacyInfo info) async {
  try {
    //TODO: Add userID and token
    // final user = Provider.of<MyModel>(context, listen: false);
    // user.authUser();

    print("PATCH Request...");
    final response = await Dio().patch(EndPoints.mockBaseUrl + '/user/perm?ID=1',
        options: Options(
            headers: {
              "authorization": "Bearer yJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYwOGQ1NWM3ZTUxMmI3NGVlMDA3OTFkYiIsImlhdCI6MTYyMTUwOTY5NywiZXhwIjoxNjI5Mjg1Njk3fQ.3WLVIdzDgIGpru3ybIxqWj9A9ROvtLG90dFuzHowuk0",
              //user.getToken()
            },
            validateStatus: (_) {
              return true;
            },
            responseType: ResponseType.json),
        data: jsonEncode({
          "privacySettings": {
            "defaults": {
              "perms": {
                "see": info.def,
                "comment": info.def,
                "addNotes": info.def,
              },
              "mapVisible": info.location,
              "importEXIF": info.importEXIF,
              "safetyLevel": info.safetyLevel,
            },
            "filters": {
              "search": {
                "safetySearch": info.safeSearch == 1 ? true : false
              }
            }
          },
        },
        ));
    // print(response);
    var responseBody = response.data;
    if (response.statusCode == 200) {

      return PrivacyInfo.fromJson(jsonDecode(responseBody));

    } else {

      throw Exception('An error occured');
    }
  } catch (error) {
    print(error);
  }
}


/// Sends GET request for obtaining privacy settings using the [PrivacyInfo] parameter
///
/// Returns [PrivacyInfo] Object that contains the privacy settings obtained from the response
Future<PrivacyInfo> getPrivacy() async {

  //TODO: Add userID and token
  // final user = Provider.of<MyModel>(context, listen: false);
  // user.authUser();

  print("GET Request.....");
  final response =
  await http.get(Uri.parse(EndPoints.mockBaseUrl + '/user/perm?ID=1'),
      headers: {
        HttpHeaders.authorizationHeader:' Bearer yJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYwOGQ1NWM3ZTUxMmI3NGVlMDA3OTFkYiIsImlhdCI6MTYyMTUwOTY5NywiZXhwIjoxNjI5Mjg1Njk3fQ.3WLVIdzDgIGpru3ybIxqWj9A9ROvtLG90dFuzHowuk0'
        //user.getToken()
      }
  );

  if (response.statusCode == 200) {
    return PrivacyInfo.fromJson(jsonDecode(response.body));

  } else {

    throw Exception('An error occurred');
  }
}
