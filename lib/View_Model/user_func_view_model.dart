import 'dart:convert';

import 'package:flickr/Constants/constants.dart';
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
    print(info);
    print(info.length);
    // int noOfFollowing = jsonDecode(data)["count"];
    return info;
  }
}
