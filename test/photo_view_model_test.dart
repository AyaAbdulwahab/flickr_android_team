import 'package:flickr/Models/photo_model.dart';
import 'package:flickr/View_Model/photo_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' show Client;
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mockito/mockito.dart';
import '../lib/Constants/constants.dart';

class MockPhotoDetails extends Mock implements Client {
}
class MockFave extends Mock implements Client {

}

void main() {

  /// [isFaved] function success
  test('Return whether a photo is faved by a user', () async {
    final client = MockFave();
    String id = "608d55c7e512b74ee00791de";
    String photoId = "608d55c7e512b74ee00791de";
    when(client.get(Uri.parse(EndPoints.baseUrl + '/user/' + id + '/faves'),
    )).thenAnswer((_) async => http.Response('Success', 200));
    expect(await isFaved(id, photoId), isA<bool>());
  });

  /// [isFaved] function failure
  test('Return whether a photo is faved by a user', () async {
    final client = MockFave();
    String id = " ";
    String photoId = "608d55c7e512b74ee00791de";
    when(client.get(Uri.parse(EndPoints.baseUrl + '/user/' + id + '/faves'),
    )).thenAnswer((_) async => http.Response('User not Found', 404));
    expect(await isFaved(id, photoId), null);
  });
}