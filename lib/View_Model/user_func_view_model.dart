import 'dart:convert';

import 'package:flickr/Constants/constants.dart';
import 'package:flickr/Models/photo_model.dart';
import 'package:http/http.dart' as http;

/// This function get the number of followers of a user through
/// his/her [id] and [token]
Future<dynamic> getCameraRoll(String token) async {
  var req = await http.get(
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

///Gets the stream of public photos of a user using the [userId]
public(String userId) async {
  var req = await http
      .get((Uri.parse(EndPoints.baseUrl + '/user/' + userId + '/stream')));
  // var req = await http.get((Uri.parse(
  //     'https://run.mocky.io/v3/9d099f64-ac41-49ea-b53b-46f658eb2a78')));

  if (req.statusCode == 200) {
    var data = jsonDecode(req.body)['data']['photos']['photos'];
    // print(data);
    // var data= jsonDecode(response.body)['data']
    List<PhotosIDsPublic> photoIds = PhotosIDsPublic.parseList(data);
    return photoIds;
  } else {
    throw Exception("An error occurred during public request");
  }
}
