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






Future<Map<String, dynamic>> signUp(String firstName, String lastName, int age,
    String email, String password, String displayName) async {
  try {
    final response = await Dio().post(EndPoints.baseUrl + '/user/sign-up',
        options: Options(validateStatus: (status) {
          return true;
        }),
        data: json.encode({
          "firstName": firstName,
          "lastName": lastName,
          "displayName": displayName,
          "age": age,
          "email": email,
          "password": password
        }));

    if (response.statusCode == 200) {
      if (response.data['token'] != null) {
        return response.data;
      } else {
        print(response.data);
      }
    }
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
  final response = await Dio().post(
      EndPoints.mockBaseUrl + '/user/sign-in?ID=1',
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


/// Sends PATCH request with [token] and [ID] as headers for updating privacy settings using the [PrivacyInfo] parameter
///
/// Returns [PrivacyInfo] Object with the new privacy settings obtained from the response
Future <PrivacyInfo> updatePrivacy(PrivacyInfo info) async {
  try {
    //TODO: Add userID and token
    // final user = Provider.of<MyModel>(context, listen: false);
    // user.authUser();

    print("PATCH Request...");
    final response = await Dio().patch(EndPoints.mockBaseUrl + '/user/perm?ID=1',
        options: Options(
            headers: {
              "authorization": "Bearer yJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYwOGQ1NWM3ZTUxMmI3NGVlMDA3OTFkYiIsImlhdCI6MTYyMTUwOTY5NywiZXhwIjoxNjI5Mjg1Njk3fQ.3WLVIdzDgIGpru3ybIxqWj9A9ROvtLG90dFuzHowuk0",
              //user.getToken()
            },
            validateStatus: (_) {
              return true;
            },
            responseType: ResponseType.json),
        data: jsonEncode({
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
              "search": {
                "safetySearch": info.safeSearch == 1 ? true : false
              }
            }
          },
        },
        ));
    // print(response);
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
Future<PrivacyInfo> getPrivacy() async {

  //TODO: Add userID and token
  // final user = Provider.of<MyModel>(context, listen: false);
  // user.authUser();

  print("GET Privacy Request.....");
  final response =
  await http.get(Uri.parse(EndPoints.mockBaseUrl + '/user/perm?ID=1'),
      headers: {
        HttpHeaders.authorizationHeader:' Bearer yJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYwOGQ1NWM3ZTUxMmI3NGVlMDA3OTFkYiIsImlhdCI6MTYyMTUwOTY5NywiZXhwIjoxNjI5Mjg1Njk3fQ.3WLVIdzDgIGpru3ybIxqWj9A9ROvtLG90dFuzHowuk0'
        //user.getToken()
      }
  );

  if (response.statusCode == 200) {
    return PrivacyInfo.fromJson(jsonDecode(response.body));

  } else {

    throw Exception('An error occurred');
  }
}



searchByUser(String searchText, int limit, int page)  async{
  //TODO: Add userID ?
  String lim="$limit";
  String pg="$page";
  print("Searching for users...");
  Map<String, String> queryParams = {
    'searchText': searchText,
    'limit': lim,
    'page':pg,
  };
  // var uri =
  // Uri.https(EndPoints.mockBaseUrl, '/user/search', queryParameters);

  String queryString = Uri(queryParameters: queryParams).query;
  var requestUrl = EndPoints.mockBaseUrl + '?' + queryString; // result - https://www.myurl.com/api/v1/user?param1=1&param2=2
  final response = await http.get(Uri.parse(requestUrl));


  if (response.statusCode == 200) {
    print("200 OK");
    // print(response.body);
    var data=  json.decode(response.body)['data'];
    // Iterable l = data;
    // List <SearchedUser> fetchedUsers = List<SearchedUser>.from(l.map((model)=> SearchedUser.fromJson(model)));
    List <SearchedUser> fetchedUsers = SearchedUser.parseList(data);
    // print("parsed");
    // usersResult.addAll(fetchedUsers);
    // var result =  List.from(usersResult)..addAll(fetchedUsers);
    // print("Returning...");
    return fetchedUsers;
    // return  usersFromJson(response.body); //Appending results not replacing them

  } else {
    print(response.statusCode);
    throw Exception('An error occurred during users search request');
  }
}



searchByPhoto(String searchText, int limit, int page)  async{
  //TODO: Add userID ?
  String lim="$limit";
  String pg="$page";
  print("Searching for photos...");
  Map<String, String> queryParams = {
    'searchText': searchText,
    'limit': lim,
    'page':pg,
  };
  String queryString = Uri(queryParameters: queryParams).query;
  var requestUrl = EndPoints.mockBaseUrl + '?' + queryString;
  final response = await http.get(Uri.parse(requestUrl));

  if (response.statusCode == 200) {
    print("200 OK");
    // print(response.body);
    var data=  json.decode(response.body)['data'];
    // Iterable l = data;
    // List <SearchedPhoto> fetchedPhotos = List<SearchedPhoto>.from(l.map((model)=> SearchedPhoto.fromJson(model)));
    List <SearchedPhoto> fetchedPhotos = SearchedPhoto.parseList(data);
    // print("parsed");
    // usersResult.addAll(fetchedPhotos);
    // var result =  List.from(usersResult)..addAll(fetchedPhotos);
    // print("Returning...");
    return fetchedPhotos;
    // return  usersFromJson(response.body); //Appending results not replacing them
  } else {
    print(response.statusCode);
    throw Exception('An error occurred during photo search request');
  }
}

/// Sends a POST request contain [email] in the body to send password reset instructions for the account associated with [email]
forgotPassword(String email) async{
  final response = await Dio().post(
      EndPoints.mockBaseUrl + '/user/forget-password?ID=1',
      // 'https://run.mocky.io/v3/405105a2-6f9b-40fc-ace5-bdde5fa186db',
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


Future <List<UserAlbum>> getUserAlbums() async {

//TODO: Add token


  // final response =
  // await http.get(Uri.parse(EndPoints.mockBaseUrl + '/user/perm?ID=1'),
  //     headers: {
  //       HttpHeaders.authorizationHeader:' Bearer yJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYwOGQ1NWM3ZTUxMmI3NGVlMDA3OTFkYiIsImlhdCI6MTYyMTUwOTY5NywiZXhwIjoxNjI5Mjg1Njk3fQ.3WLVIdzDgIGpru3ybIxqWj9A9ROvtLG90dFuzHowuk0'
  //       //user.getToken()
  //     }
  // );
  print('Requesting User Albums...');
  final response =
  await http.get(Uri.parse( 'https://run.mocky.io/v3/b61f1405-1fd0-4ba0-bc78-268d05ce7a04'));

  var data= jsonDecode(response.body)['data'];

  if (response.statusCode == 200) {

    List <UserAlbum> albums = UserAlbum.parseList(data);
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


///Gets the explore stream of photos to be displayed
explore(int page, int limit) async
{
  //TODO: ADD limit and page as query parameters
  var req = await http.get((Uri.parse(EndPoints.baseUrl + '/photo/explore' )));
  // var req = await http.get((Uri.parse('https://run.mocky.io/v3/a38e87fd-8658-46fa-9e76-d3782f653c4f')));

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

///Gets the stream of public photos of a user using the [userId]
public(String userId) async
{
  //TODO: ADD limit and page as query parameters
  // var req = await http.get((Uri.parse(EndPoints.baseUrl + '/user/' + userId + '/stream')));
  var req = await http.get((Uri.parse('https://run.mocky.io/v3/9d099f64-ac41-49ea-b53b-46f658eb2a78')));

  if (req.statusCode == 200) {
    var data= jsonDecode(req.body)['data']['photos']['photos'];
    // print(data);
    // var data= jsonDecode(response.body)['data']
    List <PhotosIDsPublic> photoIds = PhotosIDsPublic.parseList(data);
    return photoIds;
  }
  else
  {
    throw Exception ("An error occurred during public request");
  }
}

///Gets all details of a photo using the [photoId]
getPhotoDetails(String photoId) async {
  // var response = await http.get((Uri.parse(EndPoints.baseUrl + '/photo/' + photoId)));
  var response = await http.get((Uri.parse('https://run.mocky.io/v3/b8eb78d6-0716-4804-8bea-2f116ba788d0')));
  if (response.statusCode == 200) {
    var data = jsonDecode(response.body)['data'];
    return PhotoDetails.fromJson(data);
  }
  else
  {
    throw Exception ("An error occurred during photoDetails request");
  }
}

/// The function addFave adds the photo from the user's faves using the [photoId] and the user's [token]
void addFave(String photoID, String token) async {
  var req2 = await Dio().post(
      (EndPoints.baseUrl + '/user/faves/' + photoID),
      options: Options(
        headers: {"authorization": "Bearer " + token},)
  );
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
  var req2 = await Dio().delete(
      (EndPoints.baseUrl + '/user/faves/' + photoID),
      options: Options(
        headers: {"authorization": "Bearer " + token},)
  );
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
