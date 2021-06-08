import 'package:intl/intl.dart';

///The [PhotoIDs] model contains the list of photo IDs that are returned from the explore view request
class PhotosIDs {
  PhotosIDs({this.id});
  String id;
  factory PhotosIDs.fromJson(Map<String, dynamic> json) =>
      PhotosIDs(id: json['photo']['_id']);

  static List<PhotosIDs> parseList(List<dynamic> list) {
    return list.map((i) => PhotosIDs.fromJson(i)).toList();
  }
}

///The [PhotosIDsPublic] contains the list of photo IDs that are returned from the public view request
class PhotosIDsPublic {
  PhotosIDsPublic({this.id});
  String id;
  factory PhotosIDsPublic.fromJson(Map<String, dynamic> json) =>
      PhotosIDsPublic(id: json['_id']);

  static List<PhotosIDsPublic> parseList(List<dynamic> list) {
    return list.map((i) => PhotosIDsPublic.fromJson(i)).toList();
  }
}

///The [PhotoDetails] contains all the details of a photo that return from the Photo Info request
class PhotoDetails {
  PhotoDetails({
    this.userID,
    this.userName,
    this.userRealName,
    this.userImage,
    this.postImage,
    this.tags,
    this.caption,
    this.description,
    this.postDate,
    this.dateTaken,
    this.postFaves,
    this.views,
    this.permissions,
    this.commentsCount,
  });

  String userID;
  String userImage;
  String postImage;
  String userName;
  String userRealName;
  String caption; //also title
  String postDate;
  int postFaves;
  bool permissions;
  int views;
  String token;
  String description;
  String dateTaken;
  int commentsCount;
  List<dynamic> tags;

  factory PhotoDetails.fromJson(Map<String, dynamic> json, String userName) {
    List<dynamic> postComments = json['comments'] ?? [];
    return PhotoDetails(
      userID: json['userId']['_id'],
      userName: json['userId']['firstName'] + " " + json['userId']['lastName'],
      userImage:
          'https://images.unsplash.com/photo-1542103749-8ef59b94f47e?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cGVyc29ufGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80',
      postImage: json['sizes']['size']['original']['source'],
      tags: json['tags'] ?? [],
      caption: json['title'] ?? "",
      description: json['description'] ?? "",
      postDate: DateFormat.yMd().format(DateTime.parse(json['dateUploaded'])),
      dateTaken: json['dateTaken'] ?? "0",
      postFaves: json['favourites'] ?? 0,
      views: json['views'],
      permissions: json['permissions']['public'],
      commentsCount: postComments.length,
    );
  }
}
