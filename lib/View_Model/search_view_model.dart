import 'dart:convert';

import 'package:flickr/Constants/constants.dart';
import 'package:flickr/Models/photo_model.dart';
import 'package:flickr/Models/search_model.dart';
import 'package:http/http.dart' as http;

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

///Gets the explore stream of photos to be displayed
explore(int page, int limit) async {
  var req = await http.get((Uri.parse(EndPoints.baseUrl + '/photo/explore')));
  // print(req.body);
  // var req = await http.get((Uri.parse('https://run.mocky.io/v3/a38e87fd-8658-46fa-9e76-d3782f653c4f')));

  if (req.statusCode == 200) {
    var data = jsonDecode(req.body)['data']['photos'];
    // print(data);
    // var data= jsonDecode(response.body)['data']
    List<PhotosIDs> photoIds = PhotosIDs.parseList(data);
    return photoIds;
  } else {
    throw Exception("An error occurred during explore request");
  }
}
