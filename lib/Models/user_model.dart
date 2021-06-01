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


// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);



// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);




// String welcomeToJson(AllUsers data) => json.encode(data.toJson());



class SearchedUser {
  SearchedUser({
    @required this.userID,
    @required this.username,
    @required this.photoCount,
    @required this.followerCount,
  });

  String userID;
  String username;
  String photoCount;
  String followerCount;

  factory SearchedUser.fromJson(Map<String, dynamic> json) => SearchedUser(
    userID: json["_id"],
    username: json["displayName"],
    photoCount: json["photoCount"],
    followerCount: json["followerCount"],
  );

  static List<SearchedUser> parseList(List<dynamic> list) {
    return list.map((i) => SearchedUser.fromJson(i)).toList();
  }

  // Map<String, dynamic> toJson() => {
  //   "_id": userID,
  //   "displayName": username,
  //   "photoCount": photoCount,
  //   "followerCount": followerCount,
  // };
}


class SearchedPhoto {
  SearchedPhoto({
    this.originalHeight,
    this.originalWidth,
    this.originalSource,
    this.originalURL,
    this.thumbHeight,
    this.thumbWidth,
    this.thumbSource,
    this.thumbURL,
    this.favs,
    this.comments,
    this.canDownload,
    this.title,
    this.descrip,
    this.username,
    this.dateTaken,
    this.pro
  });

  int originalHeight;
  int originalWidth;
  int thumbHeight;
  int thumbWidth;
  int favs;
  int comments;
  String originalSource;
  String originalURL;
  String thumbSource;
  String thumbURL;
  String title;
  String descrip;
  String dateTaken;
  String username;
  bool canDownload;
  bool pro;


  factory SearchedPhoto.fromJson(Map<String, dynamic> json) =>
      SearchedPhoto(
        originalHeight: json['sizes']['size']['original']['height'],
        originalWidth: json['sizes']['size']['original']['width'],
        thumbHeight: json['sizes']['size']['thumbnail']['height'],
        thumbWidth: json['sizes']['size']['thumbnail']['width'],
        favs: json['favourites'],
        comments: json['comments'],
        originalSource: json['sizes']['size']['original']['source'],
        originalURL: json['sizes']['size']['original']['url'],
        thumbSource: json['sizes']['size']['thumbnail']['source'],
        thumbURL: json['sizes']['size']['original']['url'],
        title: json['title'],
        descrip: json['description'],
        dateTaken: json['dateTaken'],
        username: json['userId']['firstName'],
        canDownload: json['sizes']['size']['canDownload'],
        pro: json['userId']['pro'],
      );

  static List<SearchedPhoto> parseList(List<dynamic> list) {
    return list.map((i) => SearchedPhoto.fromJson(i)).toList();
  }
}