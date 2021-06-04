import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flickr/Constants/constants.dart';
import 'package:flickr/Models/photo_model.dart';
import 'package:flickr/View_Model/user_view_model.dart';
import 'package:http/http.dart' as http;

import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

///Gets all details of a photo using the [photoId]
getPhotoDetails(String photoId, String token) async {
  var response =
      await http.get(Uri.parse(EndPoints.baseUrl + '/photo/' + photoId));

  if (response.statusCode == 200) {
    // print(response.body);
    var data = jsonDecode(response.body)['data'];
    var userName;
    try {
      userName = await getUsername(data["userId"], token);
      print("USERAME: " + userName);
    } catch (e) {
      print(e);
    }
    return PhotoDetails.fromJson(data, userName);
  } else {
    throw Exception("An error occurred during photoDetails request");
  }
}

/// The function addFave adds the photo from the user's faves using the [photoId] and the user's [token]
void addFave(String photoID, String token) async {
  var req2 = await Dio().post((EndPoints.baseUrl + '/user/faves/' + photoID),
      options: Options(
        headers: {"authorization": "Bearer " + token},
      ));
  print(req2.data);
}

/// The function removeFave removes the photo from the user's faves using the [photoId] and the user's [token]
void removeFave(String photoID, String token) async {
  var req2 = await Dio().delete((EndPoints.baseUrl + '/user/faves/' + photoID),
      options: Options(
        headers: {"authorization": "Bearer " + token},
      ));
  print(req2.data);

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
