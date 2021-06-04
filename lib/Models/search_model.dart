import 'package:flutter/material.dart';

/// The [SearchedUser] class holds the data of the user parsed from the search request
class SearchedUser {
  SearchedUser({
    @required this.userID,
    @required this.username,
    @required this.photoCount,
    @required this.followerCount,
  });

  String userID;
  String username;
  int photoCount;
  int followerCount;

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

/// The [SearchedPhoto] class holds the data of the photo parsed from the search request
class SearchedPhoto {
  SearchedPhoto(
      {this.originalHeight,
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
      this.pro});

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

  factory SearchedPhoto.fromJson(Map<String, dynamic> json) => SearchedPhoto(
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
        canDownload: json['sizes']['canDownload'],
        pro: json['userId']['pro'],
      );

  static List<SearchedPhoto> parseList(List<dynamic> list) {
    return list.map((i) => SearchedPhoto.fromJson(i)).toList();
  }
}
