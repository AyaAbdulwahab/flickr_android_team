import 'package:flickr/Models/albums_model.dart';
import 'package:flickr/View_Model/albums_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' show Client;
import 'package:mockito/mockito.dart';
import '../lib/Constants/constants.dart';


class MockAlbums extends Mock implements Client {

}


void main() {
  ///GET Request to retrieve current user albums Success
  test('GET Request to retrieve current user albums Success',() async{
    final client = MockAlbums ();
    String token="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYwOGQ1NWM3ZTUxMmI3NGVlMDA3OTFkYiIsImlhdCI6MTYyMTUwOTY5NywiZXhwIjoxNjI5Mjg1Njk3fQ.3WLVIdzDgIGpru3ybIxqWj9A9ROvtLG90dFuzHowuk0";
    String id="608d55c7e512b74ee00791de";
    when(client.get(Uri.parse(EndPoints.baseUrl + '/user/albums'),
      headers: {"authorization": "Bearer " +token},
    )).thenAnswer((_)async => http.Response('Success',200));
    expect(await getUserAlbums(true,id,token),isA<List<UserAlbum>>());
  });

  ///GET Request to retrieve current user albums failure
  test('GET Request to retrieve current user albums failure',() async{
    final client = MockAlbums ();
    String token="eyJpZCI6IjYwOGQ1NWM3ZTUxMmI3NGVlMDA3OTFkYiIsImlhdCI6MTYyMTUwOTY5NywiZXhwIjoxNjI5Mjg1Njk3fQ.3WLVIdzDgIGpru3ybIxqWj9A9ROvtLG90dFuzHowuk0";
    String id="608d55c7e0791de";
    when(client.get(Uri.parse(EndPoints.baseUrl + '/user/albums'),
      headers: {"authorization": "Bearer " +token},
    )).thenAnswer((_)async => http.Response('Unauthorized',401));
    expect( getUserAlbums(true,id,token),throwsException);
  });


  ///GET Request to retrieve another user's albums Success
  test("GET Request to retrieve another user's albums Success",() async{
    final client = MockAlbums ();
    String token="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYwOGQ1NWM3ZTUxMmI3NGVlMDA3OTFkYiIsImlhdCI6MTYyMTUwOTY5NywiZXhwIjoxNjI5Mjg1Njk3fQ.3WLVIdzDgIGpru3ybIxqWj9A9ROvtLG90dFuzHowuk0";
    String id="608d55c7e512b74ee00791de";
    when(client.get(Uri.parse(EndPoints.baseUrl+'/user/' + id + '/albums'),
      headers: {"authorization": "Bearer " +token},
    )).thenAnswer((_)async => http.Response('Success',200));
    expect(await getUserAlbums(false,id,token),isA<List<UserAlbum>>());
  });


  ///GET Request to retrieve another user's albums failure
  test("GET Request to retrieve another user's albums failure",() async{
    final client = MockAlbums ();
    String token="JpZCI6IjYwOGQ1NWM3ZTUxMmI3NGVlMDA3OTFkYiIsImlhdCI6MTYyMTUwOTY5NywiZXhwIjoxNjI5Mjg1Njk3fQ.3WLVIdzDgIGpru3ybIxqWj9A9ROvtLG90dFuzHowuk0";
    String id="608d512b74ee00791de";
    when(client.get(Uri.parse(EndPoints.baseUrl+'/user/' + id + '/albums'),
      headers: {"authorization": "Bearer " +token},
    )).thenAnswer((_)async => http.Response('Unauthorized',401));
    expect( getUserAlbums(false,id,token),throwsException);
  });
}