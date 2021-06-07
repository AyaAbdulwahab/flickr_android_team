import 'package:flickr/Models/user_model.dart';
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
class MockPrivacySettings extends Mock implements Client {

}


void main() {
  test('Return User Privacy Settings',() async{
   // BuildContext context=BuildContext();
   //  final user = Provider.of<MyModel>(context, listen: false);

    final client = MockPrivacySettings ();
    String token="jfkdjflkdjglkjlgjlkjgldr";
    // user.setToken(token);
    when(client.get(Uri.parse(EndPoints.baseUrl + '/user/perm'),
      headers: {"authorization": "Bearer " +token},
    )).thenAnswer((_)async => http.Response('{"model":"whatever"}',200));
    expect(await getPrivacy(token),isA<PrivacyInfo>());
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