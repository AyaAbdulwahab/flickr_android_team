import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flickr/Constants/constants.dart';

/// [signUp] send a request to the backend with the [firstName], [lastName], [age],
/// [email] and [password] in the body and takes the first part of the email to be
/// used as a [displayName]
Future signUp(String firstName, String lastName, int age, String email,
    String password, String displayName) async {
  try {
    final response = await Dio().post(EndPoints.baseUrl + '/user/sign-up',
        options: Options(
            validateStatus: (status) {
              return true;
            },
            responseType: ResponseType.json),
        data: json.encode({
          "firstName": firstName,
          "lastName": lastName,
          "displayName": displayName,
          "age": age,
          "email": email,
          "password": password
        }));
    return response.data;
  } catch (error) {
    print(error.toString());
  }
}

/// Sends a post request containing [email] and [password] of the user to the url, and returns the response
logIn(String email, String password) async {
  final response = await Dio().post(EndPoints.baseUrl + '/user/sign-in',
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

/// Sends a POST request contain [email] in the body to send password reset instructions for the account associated with [email]
Future<Response> forgotPassword(String email) async {
  final response = await Dio().post(EndPoints.baseUrl + '/user/forget-password',
      options: Options(
          validateStatus: (_) {
            return true;
          },
          responseType: ResponseType.json),
      data: jsonEncode({
        "email": email,
      }));
  print(response);
  return response;
}
