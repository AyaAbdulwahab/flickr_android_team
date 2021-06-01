// import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:meta/meta.dart';
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


/// The [PrivacyInfo] class holds the privacy data obtained for the user
///
/// Is used for sending privacy requests and parsing data from responses
class PrivacyInfo {
  int def;
  int location;
  int safetyLevel;
  bool importEXIF;
  int safeSearch;
  PrivacyInfo({
    @required this.def,
    @required this.location,
    @required this.safetyLevel,
    @required this.importEXIF,
    @required this.safeSearch,
  });



  factory PrivacyInfo.fromJson(Map<String, dynamic> json) {
    bool jsonSafeS=json['data']['privacySettings']['filters']['search']['safeSearch'];
    // print(json['data']['privacySettings']['defaults']['importEXIF']);
    int safeS;
    if (jsonSafeS==true) {
      safeS=1;
    }
    else  {
      safeS=2;
    }

    return PrivacyInfo(
      def: json['data']['privacySettings']['defaults']['perms']['see'],
      location: json['data']['privacySettings']['defaults']['mapVisible'],
      importEXIF:json['data']['privacySettings']['defaults']['importEXIF'],
      safetyLevel: json['data']['privacySettings']['defaults']['safetyLevel'],
      safeSearch: safeS,
    );
  }
}