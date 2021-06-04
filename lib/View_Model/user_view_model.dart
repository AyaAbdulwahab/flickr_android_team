import 'dart:convert';
import 'package:flickr/Constants/constants.dart';
import 'package:http/http.dart' as http;

/// This function get the user real name through his/her [id] and [token]
/// And if the user's name is more than 15 chars, we only take the first
/// 15 chars and remove any whitespace
Future<dynamic> getUsername(String id, String token) async {
  var req = await http.get(
    (Uri.parse(EndPoints.baseUrl + '/user/' + id + '/real-name')),
    headers: {"authorization": "Bearer " + token},
  );
  if (req.statusCode == 200) {
    String data = req.body;
    print(data);
    Map<String, dynamic> info = jsonDecode(data)['data'];
    String name = info["firstName"] + " " + info["lastName"];
    return (name.length >= 19) ? name.substring(0, 15).trim() : name.trim();
  } else {
    print(req.body);
  }
}

/// This function get the user real name through his/her [id]
/// And if the user's name is more than 15 chars, we only take the first
/// 15 chars and remove any whitespace
Future<dynamic> getDisplayName(String id) async {
  var req = await http.get(
    (Uri.parse(EndPoints.baseUrl + '/user/' + id + '/display-name')),
  );
  if (req.statusCode == 200) {
    String data = req.body;
    print(data);
    Map<String, dynamic> info = jsonDecode(data)['data'];
    String name = info["displayName"];
    return (name.length >= 19) ? name.substring(0, 15).trim() : name.trim();
  } else {
    print(req.body);
  }
}

/// This function get the number of followers of a user through
/// his/her [id] and [token]
Future<dynamic> getNoOfFollowers(String id, String token) async {
  var req = await http.get(
    (Uri.parse(EndPoints.baseUrl + '/user/' + id + '/following')),
    headers: {"authorization": "Bearer " + token},
  );
  if (req.statusCode == 200) {
    String data = req.body;
    print(data);
    int noOfFollowing = jsonDecode(data)["count"];
    return noOfFollowing;
  }
}

/// This function gets the list of followers of a user through his/her
/// [id] and [token]

Future<dynamic> getFollowers(String id, String token) async {
  var req = await http.get(
    (Uri.parse(EndPoints.baseUrl + '/user/' + id + '/following')),
    headers: {"authorization": "Bearer " + token},
  );
  if (req.statusCode == 200) {
    String data = req.body;
    print(data);
    List noOfFollowing = jsonDecode(data)["data"]["following"];
    return noOfFollowing;
  }
}
