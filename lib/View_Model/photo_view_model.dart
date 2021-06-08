import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flickr/Constants/constants.dart';
import 'package:flickr/Models/photo_model.dart';
import 'package:flickr/View_Model/user_view_model.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' show Client;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

///The [getPhotoDetails] function gets all details of a photo using the [photoId]
getPhotoDetails(String photoId, String token) async {
  Client client=Client();
  var response =
      await http.get(Uri.parse(EndPoints.baseUrl + '/photo/' + photoId));

  if (response.statusCode == 200) {
    // print(response.body);
    var data = jsonDecode(response.body)['data'];
    var userName;
    try {
      userName = await getUsername(data["userId"]["_id"], token);
      print("USERAME: " + userName);
      return PhotoDetails.fromJson(data, userName);
    } catch (e) {
      print(e);
    }
  } else {
    throw Exception("An error occurred during photoDetails request");
  }
}

/// The [addFave] function adds the photo to the user's faves using the [photoId] and the user's [token]
void addFave(String photoID, String token) async {
  var req2 = await Dio().post((EndPoints.baseUrl + '/user/faves/' + photoID),
      options: Options(
        headers: {"authorization": "Bearer " + token},
      ));
  print(req2.data);
}

/// The [removeFave] function removes the photo from the user's faves using the [photoId] and the user's [token]
void removeFave(String photoID, String token) async {
  var req2 = await Dio().delete((EndPoints.baseUrl + '/user/faves/' + photoID),
      options: Options(
        headers: {"authorization": "Bearer " + token},
      ));
  print(req2.data);
}

/// [getImage] pickes and image from the [gallery] and returns a [File]
Future<File> getImage() async {
  var image = await ImagePicker().getImage(source: ImageSource.gallery);
  return File(image.path);
}

/// The photo is sent by [sendPhoto] to upload it to the backend.
Future sendPhoto(String token) async {
  File a = await getImage();
  String fileName = a.path.split('/').last;
  print(a);

  FormData formData = new FormData.fromMap({
    "title": "title",
    "description": "desc",
    "photo": await MultipartFile.fromFile(a.path,
        filename: fileName, contentType: MediaType('image', 'jpg')),
  });
  print("FORMDATAAA: " + fileName);
  try {
    Dio dio = new Dio();
    dio.options.headers = {"authorization": "Bearer " + token};
    var response =
        await dio.post(EndPoints.baseUrl + "/photo/", data: formData);
    print(response);
  } catch (e) {
    print(e);
  }
}

/// [deletePhoto] deletes a user photo by taking the photo's Id and the user's token
deletePhoto(String photoID, String token) async {
  var req2 = await Dio().delete((EndPoints.baseUrl + '/photo/' + photoID),
      options: Options(
        headers: {"authorization": "Bearer " + token},
      ));
  return req2;
}

///The [isFaved] function returns a boolean that represents whether or not a user with ID [id] faved the photo with ID [photoID]
isFaved(String id, String photoID) async {
  Client client=Client();
  var resp =
      await http.get(Uri.parse(EndPoints.baseUrl + '/user/' + id + '/faves'));
  if (resp.statusCode == 200) {
    var data = jsonDecode(resp.body)['data']['favourites'];

    for (var i = 0; i < data.length; i++) {
      if (data[i]["_id"] == photoID) return true;
    }

    return false;
  } else {
    return null;
  }
}
