import 'dart:convert';

import 'package:flickr/Constants/constants.dart';
import 'package:flickr/Models/photo_model.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' show Client;

/// This function get the number of followers of a user through
/// his/her [id] and [token]
Future<dynamic> getCameraRoll(String token) async {
  Client client=Client();
  var req = await client.get(
    (Uri.parse(EndPoints.baseUrl + '/user/camera-roll')),
    headers: {"authorization": "Bearer " + token},
  );
  if (req.statusCode == 200) {
    String data = req.body;
    List info = jsonDecode(data)['data']["photos"]["photos"];
    // print(info);
    print("LENGTH: " + info.length.toString());
    // int noOfFollowing = jsonDecode(data)["count"];
    return info;
  }
}

///The [getPhotosCount] gets the Photo count of a user using [token]
Future<int> getPhotosCount(String token) async {
  List response = await getCameraRoll(token);
  return response.length;
}

///The [public] function gets the stream of public photos of a user using their [userId]
Future public(String userId, String token) async {
  Client client=Client();
  var req = await client.get(
    (Uri.parse(EndPoints.baseUrl + '/user/' + userId + '/stream')),
    headers: {"authorization": "Bearer " + token},
  );

  if (req.statusCode == 200) {
    var data = jsonDecode(req.body)['data']['photos']['photos'];
    print(data);
    // print(data);
    // var data= jsonDecode(response.body)['data']
    List<PhotosIDsPublic> photoIds = PhotosIDsPublic.parseList(data);
    print(photoIds);
    return photoIds;
  } else {
    throw Exception("An error occurred during public request");
  }
}
