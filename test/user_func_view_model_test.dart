import 'package:flickr/Models/photo_model.dart';
import 'package:flickr/View_Model/user_func_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' show Client;
import 'package:mockito/mockito.dart';
import '../lib/Constants/constants.dart';

class MockPublic extends Mock implements Client {

}

void main() {

  ///[public] function success
  test('Return public photo IDs', () async {
    final client = MockPublic();
    String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYwOGQ1NWM3ZTUxMmI3NGVlMDA3OTFkYiIsImlhdCI6MTYyMTUwOTY5NywiZXhwIjoxNjI5Mjg1Njk3fQ.3WLVIdzDgIGpru3ybIxqWj9A9ROvtLG90dFuzHowuk0";
    String id = "608d55c7e512b74ee00791de";
    when(client.get(Uri.parse(EndPoints.baseUrl + '/user/' + id + '/stream'),
      headers: {"authorization": "Bearer " + token},
    )).thenAnswer((_) async => http.Response('Success', 200));
    expect(await public(id, token), isA<List<PhotosIDsPublic>>());
  });

  ///[getPhotosCount] function success
  test('Returns the photo count of a user', () async {
    String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYwOGQ1NWM3ZTUxMmI3NGVlMDA3OTFkYiIsImlhdCI6MTYyMTUwOTY5NywiZXhwIjoxNjI5Mjg1Njk3fQ.3WLVIdzDgIGpru3ybIxqWj9A9ROvtLG90dFuzHowuk0";
    expect(await getPhotosCount(token), isA<int>());
  });

}
