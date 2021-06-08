import 'package:flickr/Models/privacy_info_model.dart';
import 'package:flickr/View_Model/privacy_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' show Client;
import 'package:mockito/mockito.dart';
import '../lib/Constants/constants.dart';

class MockPrivacySettings extends Mock implements Client {

}


void main() {
  /// GET Privacy Request Success
  test('GET User Privacy Settings Success',() async{
    final client = MockPrivacySettings ();
    String token="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYwOGQ1NWM3ZTUxMmI3NGVlMDA3OTFkYiIsImlhdCI6MTYyMTUwOTY5NywiZXhwIjoxNjI5Mjg1Njk3fQ.3WLVIdzDgIGpru3ybIxqWj9A9ROvtLG90dFuzHowuk0";
    when(client.get(Uri.parse(EndPoints.baseUrl + '/user/perm'),
      headers: {"authorization": "Bearer " +token},
    )).thenAnswer((_)async => http.Response('success',200));
    expect(await getPrivacy(token),isA<PrivacyInfo>());
  });

  /// GET Privacy Request Failure
  test('GET User Privacy Settings Failure',() async{
    final client = MockPrivacySettings ();
    String token="token";
    when(client.get(Uri.parse(EndPoints.baseUrl + '/user/perm'),
      headers: {"authorization": "Bearer " +token},
    )).thenAnswer((_)async => http.Response('Unauthorized',401));
    expect( getPrivacy(token),throwsException);
  });


}