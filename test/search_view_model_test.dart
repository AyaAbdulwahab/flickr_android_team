import 'package:flickr/Models/photo_model.dart';
import 'package:flickr/View_Model/search_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' show Client;
import 'package:mockito/mockito.dart';
import '../lib/Constants/constants.dart';

class MockExplore extends Mock implements Client {

}

void main() {
  ///[explore] function success
  test('Return explore photo IDs', () async {
    final client = MockExplore();
    when(client.get(Uri.parse(EndPoints.baseUrl + '/photo/explore'),
    )).thenAnswer((_) async => http.Response('Success', 200));
    expect(await explore(1, 10), isA<List<PhotosIDs>>());
  });

}