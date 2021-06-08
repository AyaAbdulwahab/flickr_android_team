import 'package:flickr/Models/photo_model.dart';
import 'package:flickr/Models/search_model.dart';
import 'package:flickr/View_Model/search_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' show Client;
import 'package:mockito/mockito.dart';
import '../lib/Constants/constants.dart';

class MockExplore extends Mock implements Client {

}

class MockSearch extends Mock implements Client {

}


void main() {
  ///Searching for photos request success
  test('Search for photos success', () async {
    final client = MockSearch();
    int lim = 6;
    int pg = 3;
    Map<String, String> queryParams = {
      'searchText': "Hello",
      'limit': "$lim",
      'page': "$pg",
    };

    List<String> tempUrl = EndPoints.baseUrl.split("/");
    String u = tempUrl[tempUrl.length - 2];
    var uri = Uri.https(u, 'api/user/search', queryParams);
    String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYwOGQ1NWM3ZTUxMmI3NGVlMDA3OTFkYiIsImlhdCI6MTYyMTUwOTY5NywiZXhwIjoxNjI5Mjg1Njk3fQ.3WLVIdzDgIGpru3ybIxqWj9A9ROvtLG90dFuzHowuk0";
    when(client.get(uri, headers: {"authorization": "Bearer " + token})
    ).thenAnswer((_) async => http.Response('Success', 200));
    expect(await searchByPhoto("Hello", lim, pg, token),
        isA<List<SearchedPhoto>>());
  });

  /// Unsuccessful search for photos request
  test('Throws an GET request for photos search was unsuccessful', () {
    final client = MockSearch();
    String token = "1NWM3ZTUxMmI3NGVlMDA3OTFkYiIsImlhdCI6MTYyMTUwOTY5NywiZXhwIjoxNjI5Mjg1Njk3fQ.3WLVIdzDgIGpru3ybIxqWj9A9ROvtLG90dFuzHowuk0";
    int lim = 6;
    int pg = 3;
    Map<String, String> queryParams = {
      'searchText': "Hello",
      'limit': "$lim",
      'page': "$pg",
    };
    List<String> tempUrl = EndPoints.baseUrl.split("/");
    String u = tempUrl[tempUrl.length - 2];
    var uri = Uri.https(u, 'api/user/search', queryParams);
    when(client.get(uri, headers: {"authorization": "Bearer " + token})
    ).thenAnswer((_) async => http.Response('Unauthorized', 401));
    expect(searchByPhoto("Hello", lim, pg, token), throwsException);
  });

  ///Searching for users request success
  test('Search for users success', () async {
    final client = MockSearch();
    int lim = 6;
    int pg = 3;
    Map<String, String> queryParams = {
      'searchText': "Hello",
      'limit': "$lim",
      'page': "$pg",
    };

    List<String> tempUrl = EndPoints.baseUrl.split("/");
    String u = tempUrl[tempUrl.length - 2];
    var uri = Uri.https(u, 'api/user/search', queryParams);
    String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYwOGQ1NWM3ZTUxMmI3NGVlMDA3OTFkYiIsImlhdCI6MTYyMTUwOTY5NywiZXhwIjoxNjI5Mjg1Njk3fQ.3WLVIdzDgIGpru3ybIxqWj9A9ROvtLG90dFuzHowuk0";
    when(client.get(uri, headers: {"authorization": "Bearer " + token})
    ).thenAnswer((_) async => http.Response('Success', 200));
    expect(await searchByUser("Hello", lim, pg, token),
        isA<List<SearchedUser>>());
  });

  /// Unsuccessful search for user request
  test('Throws an exception when users search was unsuccessful', () {
    final client = MockSearch();
    String token = "1NWM3ZTUxMmI3NGVlMDA3OTFkYiIsImlhdCI6MTYyMTUwOTY5NywiZXhwIjoxNjI5Mjg1Njk3fQ.3WLVIdzDgIGpru3ybIxqWj9A9ROvtLG90dFuzHowuk0";
    int lim = 6;
    int pg = 3;
    Map<String, String> queryParams = {
      'searchText': "Hello",
      'limit': "$lim",
      'page': "$pg",
    };
    List<String> tempUrl = EndPoints.baseUrl.split("/");
    String u = tempUrl[tempUrl.length - 2];
    var uri = Uri.https(u, 'api/user/search', queryParams);
    when(client.get(uri, headers: {"authorization": "Bearer " + token})
    ).thenAnswer((_) async => http.Response('Unauthorized', 401));
    expect(searchByPhoto("Hello", lim, pg, token), throwsException);
  });

  ///[explore] function success
  test('Return explore photo IDs Success', () async {
    final client = MockExplore();
    when(client.get(Uri.parse(EndPoints.baseUrl + '/photo/explore'),
    )).thenAnswer((_) async => http.Response('Success', 200));
    expect(await explore(1, 10), isA<List<PhotosIDs>>());
  });

}