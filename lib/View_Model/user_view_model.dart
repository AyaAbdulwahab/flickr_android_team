import 'dart:convert';
import 'dart:io';
import '../Models/user_model.dart';
import 'package:dio/dio.dart';
import 'package:flickr/Constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../Models/user_model.dart';

/// class [MyModel] // have 2 functions to check if the current user is
/// authenticated to enter the app of not
/// the ChangeNotifier is used to inform the root of the app if any changes
/// concerning the authentication had happened
class MyModel with ChangeNotifier {
  bool isAuth = false;
  String _token;
  List followers = [];

  String _id;
  void setID(String id) {
    _id = id;
  }

  String getID() {
    return _id;
  }

  void setFollowers(List a) {
    followers = a;
  }

  List getFollowers() {
    return followers;
  }

  void setToken(String token) {
    _token = token;
  }

  String getToken() {
    return _token;
  }

  void authUser() {
    isAuth = true;
    notifyListeners();
  }

  void unAuthUser() {
    isAuth = false;
    notifyListeners();
  }
}


Future signUp(String firstName, String lastName, int age, String email,
    String password, String displayName) async {
  try {
    final response = await Dio().post(EndPoints.baseUrl + '/user/sign-up',
        options: Options(
            validateStatus: (status) {
              return true;
            },
            responseType: ResponseType.json),

        data: json.encode({
          "firstName": firstName,
          "lastName": lastName,
          "displayName": displayName,
          "age": age,
          "email": email,
          "password": password
        }));

    // print("HNAAA");

    // print(response["token"]);
    // if (response.statusCode == 200) {
    // print()
    if (response.data['token'] != null) {
      print("OK");
      return response.data;
    } else {
      print(response.data);
    }
    // }
  } catch (error) {
    print(error.toString());
  }
}

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

/// Sends a post request containing [email] and [password] of the user to the url, and returns the response
logIn(String email, String password) async {
  final response = await Dio().post(EndPoints.baseUrl + '/user/sign-in?ID=1',

      options: Options(
          validateStatus: (_) {
            return true;
          },
          responseType: ResponseType.json),
      data: jsonEncode({
        "email": email,
        "password": password,
      }));
  print(response);
  return response;
}


///--------------------------------------->
explore(int page, int limit) async
{
  //TODO: ADD limit and page as query parameters
  // var req = await http.get((Uri.parse(EndPoints.baseUrl + '/photo/explore' )));
  var req = await http.get((Uri.parse('https://run.mocky.io/v3/a38e87fd-8658-46fa-9e76-d3782f653c4f')));

  if (req.statusCode == 200) {
    var data= jsonDecode(req.body)['data']['photos'];
    // print(data);
    // var data= jsonDecode(response.body)['data']
    List <PhotosIDs> photoIds = PhotosIDs.parseList(data);
    return photoIds;
  }
  else
  {
    throw Exception ("An error occurred during explore request");
  }
}

getPhotoDetails() async {
  var response = await http
      .get((Uri.parse(
      'https://run.mocky.io/v3/ec6c1711-7e15-4185-97ab-328bb68d8342')));

  if (response.statusCode == 200) {
    var data = jsonDecode(response.body)['data'];
    return PhotoDetails.fromJson(data);
  }
  else
  {
    throw Exception ("An error occurred during photoDetails request");
  }
}


/// Sends PATCH request with [token] and [ID] as headers for updating privacy settings using the [PrivacyInfo] parameter
///
/// Returns [PrivacyInfo] Object with the new privacy settings obtained from the response
Future<PrivacyInfo> updatePrivacy(PrivacyInfo info, String token) async {
  try {
    //TODO: Add userID and token
    // final user = Provider.of<MyModel>(context, listen: false);
    // user.authUser();

    print("PATCH Request...");
    final response = await Dio().patch(EndPoints.baseUrl + '/user/perm',
        options: Options(
            headers: {"authorization": "Bearer " + token},
            validateStatus: (_) {
              return true;
            },
            responseType: ResponseType.json),
        data: jsonEncode(
          {
            "privacySettings": {
              "defaults": {
                "perms": {
                  "see": info.def,
                  "comment": info.def,
                  "addNotes": info.def,
                },
                "mapVisible": info.location,
                "importEXIF": info.importEXIF,
                "safetyLevel": info.safetyLevel,
              },
              "filters": {
                "search": {"safetySearch": info.safeSearch == 1 ? true : false}
              }
            },
          },
        ));
    var responseBody = response.data;
    if (response.statusCode == 200) {
      return PrivacyInfo.fromJson(jsonDecode(responseBody));
    } else {
      throw Exception('An error occured');
    }
  } catch (error) {
    print(error);
  }
}

/// Sends GET request for obtaining privacy settings using the [PrivacyInfo] parameter
///
/// Returns [PrivacyInfo] Object that contains the privacy settings obtained from the response
Future<PrivacyInfo> getPrivacy(String token) async {
  //TODO: Add userID and token
  // final user = Provider.of<MyModel>(context, listen: false);
  // user.authUser();

  print("GET Privacy Request.....");
  final response = await http.get(
    Uri.parse(EndPoints.baseUrl + '/user/perm'),
    headers: {"authorization": "Bearer " + token},
  );

  if (response.statusCode == 200) {
    return PrivacyInfo.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('An error occurred');
  }
}

/// Sends a GET request with [searchText], [limit] and [page] as query parameters in the URL, and [token] in the headers
///
/// Users in the results are paginated according to page number [page], and limit per page [limit]
/// Returns the result as a list of [SearchedUser]
searchByUser(String searchText, int limit, int page, String token) async {
  String lim = "$limit";
  String pg = "$page";
  print("Searching for users...");
  Map<String, String> queryParams = {
    'searchText': searchText,
    'limit': lim,
    'page': pg,
  };

  String u = EndPoints.baseUrl.split('/').last;

  var uri = Uri.http(u, '/user/search', queryParams);
  final response = await http.get(
    uri,
    headers: {"authorization": "Bearer " + token},
  );

  if (response.statusCode == 200) {
    print("200 OK");
    var data = json.decode(response.body)['data'];
    List<SearchedUser> fetchedUsers = SearchedUser.parseList(data);

    return fetchedUsers;
  } else {
    print(response.statusCode);
    throw Exception('An error occurred during users search request');
  }
}

/// Sends a GET request with [searchText], [limit] and [page] as query parameters in the URL, and [token] in the headers
///
/// Photos in the results are paginated according to page number [page], and limit per page [limit]
/// /// Returns the result as a list of [SearchedPhoto]
searchByPhoto(String searchText, int limit, int page, String token) async {
  String lim = "$limit";
  String pg = "$page";
  print("Searching for photos...");

  var queryParams = {
    'searchText': searchText,
    'limit': lim,
    'page': pg,
  };
  String u = EndPoints.baseUrl.split('/').last;

  var uri = Uri.http(u, '/photo/search', queryParams);
  final response = await http.get(
    uri,
    headers: {"authorization": "Bearer " + token},
  );

  if (response.statusCode == 200) {
    var data = json.decode(response.body)['data'];

    List<SearchedPhoto> fetchedPhotos = SearchedPhoto.parseList(data);
    return fetchedPhotos;
  } else {
    print(response.statusCode);
    throw Exception('An error occurred during photo search request');
  }
}

/// Sends a POST request contain [email] in the body to send password reset instructions for the account associated with [email]
forgotPassword(String email) async {
  final response = await Dio().post(EndPoints.baseUrl + '/user/forget-password',
      options: Options(
          validateStatus: (_) {
            return true;
          },
          responseType: ResponseType.json),
      data: jsonEncode({
        "email": email,
      }));
  print(response);
  return response;
}

/// Sends Get Request to obtain current users' albums in the profile page
Future<List<UserAlbum>> getUserAlbums(String token) async {
  print('Requesting User Albums...');
  final response = await http.get(Uri.parse(EndPoints.baseUrl + '/user/albums'),
      headers: {"authorization": "Bearer " + token});

  var data = jsonDecode(response.body)['data'];

  if (response.statusCode == 200) {
    List<UserAlbum> albums = UserAlbum.parseList(data);
    print('Returning from request');
    return albums;
  } else {
    throw Exception('An error occurred during GET albums');
  }
}

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

/// The function addFave adds the photo from the user's faves using the [photoId] and the user's [token]
void addFave(String photoID, String token) async {
  var req2 =
      await Dio().post((EndPoints.mockBaseUrl + '/user/faves/' + photoID),
          options: Options(
            headers: {"authorization": "Bearer " + token},
          ));
}
// print (req2.body);
//   data: jsonEncode({
//     'newPhotoFaveCount': {
//       'favourites': int.parse(widget.faves)+1,
//       '_id': widget.photoID,
//     },
//     "newUserFaveList": {
//       "favourites": [
//         widget.photoID
//       ],
//       "_id": widget.userID
//     }
//   });
// }

/// The function removeFave removes the photo from the user's faves using the [photoId] and the user's [token]
void removeFave(String photoID, String token) async {
  var req2 =
      await Dio().delete((EndPoints.mockBaseUrl + '/user/faves/' + photoID),
          options: Options(
            headers: {"authorization": "Bearer " + token},
          ));
  // print (req2.body);
  // data: jsonEncode({
  //   'newPhotoFaveCount': {
  //     'favourites': int.parse(widget.faves)-1,
  //     '_id':  widget.photoID,
  //   },
  //   "newUserFaveList": {
  //     "favourites": [
  //       widget.photoID
  //     ],
  //     "_id":  widget.userID
  //   }
  // });
}
