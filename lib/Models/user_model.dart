// import 'package:http/http.dart' as http;
import 'dart:convert';
// import 'package:flutter/services.dart' show rootBundle;

class User {
  String username;
  String firstname;
  String lastname;
  bool pro;
  String aboutme;
  String joindate;
  String profileurl;
  String location;

  User(
      {this.username,
      this.firstname,
      this.lastname,
      this.pro,
      this.aboutme,
      this.joindate,
      this.profileurl,
      this.location});

  // factory User.fromJson(Map<String, dynamic> json) {
  //   return User(
  //       username: json['username'],
  //       firstname: json['firstname'],
  //       lastname: json['lastname'],
  //       pro: json['pro'],
  //       aboutme: json['aboutme'] ?? " ",
  //       joindate: json['joindate'],
  //       profileurl: json['profileurl'],
  //       location: json['location']);0
  // }
}

// Future<User> getUserInfo() async {
//   Future<String> getJson() async {
//     return await rootBundle.loadString('mock_data/mock_user_data.json');
//   }

// var jsonString = await getJson();
// Map<String, dynamic> userMap = jsonDecode(jsonString);
// return User.fromJson(userMap);
// print(user.firstname);
// }
