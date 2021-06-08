import 'package:flickr/View_Model/user_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' show Client;
import 'package:mockito/mockito.dart';
import '../lib/Constants/constants.dart';

class MockUser extends Mock implements Client {

}

void main() {

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
