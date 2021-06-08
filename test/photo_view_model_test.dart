import 'package:flickr/Models/photo_model.dart';
import 'package:flickr/Models/user_model.dart';
import 'package:flickr/View_Model/photo_view_model.dart';
import 'package:flickr/View_Model/privacy_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' show Client;
import 'package:provider/provider.dart';
import 'package:mockito/mockito.dart';
import '../lib/Models/privacy_info_model.dart';
import '../lib/Constants/constants.dart';
import '../lib/Views/privacy_settings.dart';
class MockPhotoDetails extends Mock implements Client {

}

void main() {
  test('Return Photo details',() async{
    // BuildContext context=BuildContext();
    //  final user = Provider.of<MyModel>(context, listen: false);

    final client = MockPhotoDetails();
    String token="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYwOGQ1NWM3ZTUxMmI3NGVlMDA3OTFkYiIsImlhdCI6MTYyMTUwOTY5NywiZXhwIjoxNjI5Mjg1Njk3fQ.3WLVIdzDgIGpru3ybIxqWj9A9ROvtLG90dFuzHowuk0";
    String id="608d55c7e512b74ee00791de";
    // user.setToken(token);
    when(client.get(Uri.parse(EndPoints.baseUrl + '/photo/' + id),
      headers: {"authorization": "Bearer " +token},
    )).thenAnswer((_)async => http.Response('Success',200));
    expect(await getPhotoDetails(id, token),isA<PhotoDetails>());
  });


//   final MockPrivacySettings mockPrivacy= MockPrivacySettings();
//   PrivacySettings privacy= PrivacySettings();
//   PrivacyInfo p=PrivacyInfo(def: 1, location: 2, safetyLevel: 3, importEXIF: true, safeSearch: 4);
// setUp((){
//
// });
// tearDown((){});
//
//
// test("Get Privacy Settings",() async{
//   when(PrivacySettings.getPrivacy("jhfkjdrhuheiy479658hfjhsejkfhdj")).thenAnswer((realInvocation) => null);
//   expect(await mockPrivacy.getPrivacy("jhfkjdrhuheiy479658hfjhsejkfhdj"),p);
// });
}