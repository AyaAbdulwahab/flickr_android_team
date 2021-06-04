import 'package:flutter/material.dart';

///The [UserAlbum] holds parsed data of each album for the current user
class UserAlbum {
  UserAlbum({
    @required this.photoCount,
    @required this.primaryPhoto,
    @required this.albumName,
  });
  String photoCount;
  String primaryPhoto;
  String albumName;

  factory UserAlbum.fromJson(Map<String, dynamic> json) {
    int count = json['photoCount'];
    return UserAlbum(
      photoCount: "$count",
      albumName: json['album']['albumName'],
      primaryPhoto: json['album']['primaryPhotoId']['sizes']['size']
          ['largeSquare']['source'],
    );
  }
  static List<UserAlbum> parseList(List<dynamic> list) {
    return list.map((i) => UserAlbum.fromJson(i)).toList();
  }
}
