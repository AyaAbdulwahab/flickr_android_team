import 'dart:convert';

import 'package:flickr/Constants/constants.dart';
import 'package:flickr/Models/albums_model.dart';
import 'package:http/http.dart' as http;

/// Sends Get Request to obtain current users' albums in the profile page
Future<List<UserAlbum>> getUserAlbums(
    bool isMe, String id, String token) async {
  print('Requesting User Albums...');
  final response = isMe
      ? await http.get(Uri.parse(EndPoints.baseUrl + '/user/albums'),
          headers: {"authorization": "Bearer " + token})
      : await http.get(Uri.parse(EndPoints.baseUrl + '/user/' + id + '/albums'),
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
