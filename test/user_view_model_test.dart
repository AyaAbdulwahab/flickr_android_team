import 'package:flickr/View_Model/user_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' show Client;
import 'package:mockito/mockito.dart';
import '../lib/Constants/constants.dart';

class MockUser extends Mock implements Client {

}

void main() {


  ///GET current Username Success
  test('GET current Username Success',() async{
    final client = MockUser ();
    String token="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYwOGQ1NWM3ZTUxMmI3NGVlMDA3OTFkYiIsImlhdCI6MTYyMTUwOTY5NywiZXhwIjoxNjI5Mjg1Njk3fQ.3WLVIdzDgIGpru3ybIxqWj9A9ROvtLG90dFuzHowuk0";
    String id="608d55c7e512b74ee00791de";
    when (client.get(
      (Uri.parse(EndPoints.baseUrl + '/user/' + id + '/real-name')),
      headers: {"authorization": "Bearer " + token},
    )).thenAnswer((_)async => http.Response('Success',200));
    expect(await getUsername(id,token),isA<String>());
  });



  ///GET current Username Failure
  test('GET current Username Failure',() async{
    final client = MockUser ();
    String token="YwOGQ1NWM3ZTUxMmI3NGVlMDA3OTFkYiIsImlhdCI6MTYyMTUwOTY5NywiZXhwIjoxNjI5Mjg1Njk3fQ.3WLVIdzDgIGpru3ybIxqWj9A9ROvtLG90dFuzHowuk0";
    String id="2b74ee00791de";
    when (client.get(
      (Uri.parse(EndPoints.baseUrl + '/user/' + id + '/real-name')),
      headers: {"authorization": "Bearer " + token},
    )).thenAnswer((_)async => http.Response('Unauthorized',401));
    expect(await getUsername(id,token),null);
  });

  ///GET current user's display name failure
  test("GET current user's display name failure",() async{
    final client = MockUser ();
    String id="608d55c7e512b74ee00791de";
    when (client.get(
      (Uri.parse(EndPoints.baseUrl + '/user/' + id + '/display-name')),
    )).thenAnswer((_)async => http.Response('Success',200));
    expect(await getDisplayName(id),null);
  });

///GET user's number of followers Success
  test("GET user's number of followers Success",() async{
    final client = MockUser ();
    String token="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYwOGQ1NWM3ZTUxMmI3NGVlMDA3OTFkYiIsImlhdCI6MTYyMTUwOTY5NywiZXhwIjoxNjI5Mjg1Njk3fQ.3WLVIdzDgIGpru3ybIxqWj9A9ROvtLG90dFuzHowuk0";
    String id="608d55c7e512b74ee00791de";
    when (client.get(
      (Uri.parse(EndPoints.baseUrl + '/user/' + id + '/following')),
      headers: {"authorization": "Bearer " + token},
    )).thenAnswer((_)async => http.Response('Success',200));
    expect(await getNoOfFollowers(id,token),isA<int>());
  });



  ///GET user's number of followers failure
  test("GET user's number of followers Success",() async{
    final client = MockUser ();
    String token="eGQ1NWM3ZTUxMmI3NGVlMDA3OTFkYiIsImlhdCI6MTYyMTUwOTY5NywiZXhwIjoxNjI5Mjg1Njk3fQ.3WLVIdzDgIGpru3ybIxqWj9A9ROvtLG90dFuzHowuk0";
    String id="6074ee00791de";
    when (client.get(
      (Uri.parse(EndPoints.baseUrl + '/user/' + id + '/following')),
      headers: {"authorization": "Bearer " + token},
    )).thenAnswer((_)async => http.Response('Unauthorized',401));
    expect(await getNoOfFollowers(id,token),null);
  });

  ///GET user's list of followers Success
  test("GET user's list of followers Success",() async{
    final client = MockUser ();
    String token="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYwOGQ1NWM3ZTUxMmI3NGVlMDA3OTFkYiIsImlhdCI6MTYyMTUwOTY5NywiZXhwIjoxNjI5Mjg1Njk3fQ.3WLVIdzDgIGpru3ybIxqWj9A9ROvtLG90dFuzHowuk0";
    String id="608d55c7e512b74ee00791de";
    when (client.get(
      (Uri.parse(EndPoints.baseUrl + '/user/' + id + '/following')),
      headers: {"authorization": "Bearer " + token},
    )).thenAnswer((_)async => http.Response('Success',200));
    expect(await getFollowers(id,token),isA<List>());
  });



  ///GET user's list of followers failure
  test("GET user's list of followers failure",() async{
    final client = MockUser ();
    String token="eyJhbGZCI6IjYwOGQ1NWM3ZTUxMmI3NGVlMDA3OTFkYiIsImlhdCI6MTYyMTUwOTY5NywiZXhwIjoxNjI5Mjg1Njk3fQ.3WLVIdzDgIGpru3ybIxqWj9A9ROvtLG90dFuzHowuk0";
    String id="608b74ee00791de";
    when (client.get(
      (Uri.parse(EndPoints.baseUrl + '/user/' + id + '/following')),
      headers: {"authorization": "Bearer " + token},
    )).thenAnswer((_)async => http.Response('Unauthorized',401));
    expect(await getFollowers(id,token),null);
  });


  ///[getUsername] function success
  test('Return username of user', () async {
    final client = MockUser();
    String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYwOGQ1NWM3ZTUxMmI3NGVlMDA3OTFkYiIsImlhdCI6MTYyMTUwOTY5NywiZXhwIjoxNjI5Mjg1Njk3fQ.3WLVIdzDgIGpru3ybIxqWj9A9ROvtLG90dFuzHowuk0";
    String id = "608d55c7e512b74ee00791de";
    when(client.get(Uri.parse(EndPoints.baseUrl + '/user/' + id + '/real-name'),
      headers: {"authorization": "Bearer " + token},
    )).thenAnswer((_) async => http.Response('Success', 200));
    expect(await getUsername(id, token), isA<String>());
  });

  ///[getUsername] function failure
  test('Returns username of user', () async {
    final client = MockUser();
    String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYwOGQ1NWM3ZTUxMmI3NGVlMDA3OTFkYiIsImlhdCI6MTYyMTUwOTY5NywiZXhwIjoxNjI5Mjg1Njk3fQ.3WLVIdzDgIGpru3ybIxqWj9A9ROvtLG90dFuzHowuk0";
    String id = " ";
    when(client.get(Uri.parse(EndPoints.baseUrl + '/user/' + id + '/real-name'),
      headers: {"authorization": "Bearer " + token},
    )).thenAnswer((_) async => http.Response('Error', 404));
    expect(await getUsername(id, token), null);
  });

}
